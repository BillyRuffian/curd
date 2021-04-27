require 'cgi'
require 'observer'

module Curd
  class Engine
    include ::CGI::Util
    include Observable

    TEMPLATE_ROOT_PATH = File.join(File.dirname(__dir__), 'templates')

    def initialize(config)
      @configuration = config
      @template_path = File.join(TEMPLATE_ROOT_PATH, @configuration.template)
      @layout = Tilt.new(template('layout.haml'))
    end

    def render(directory)
      tree = Tree.new(directory.name)
      render_directories(directory, tree)
      File.write(File.join(@configuration.output_dir, 'index.html'), render_index(tree))

      if File.exist?(@configuration.output_dir)
        FileUtils.cp_r(template('css'), @configuration.output_dir)
      end
    end

    def render_directories(directory, tree, path = [@configuration.output_dir])
      path << directory.name
      output_to = File.join(*path)

      feature_files = directory.feature_files
      if !feature_files&.empty?
        FileUtils.mkdir_p(output_to)
        folder = tree.build(*path)
        feature_files.each do |ff|
          changed
          notify_observers(ff)
          File.write(File.join(output_to, "#{ff.name}.html"), render_feature(ff, depth: path.count) )
          folder.leaves << { dir: File.join(*path[1..-1]), name: ff.name }
        end
      end

      directory
        .children
        .filter { |c| c.kind_of?  CukeModeler::Directory }
        .each { |sub_dir| render_directories(sub_dir, tree, path.dup) }
    end

    def render_feature(feature_file, depth:)
      css = '../' * (depth - 1) + 'css/'
      output = @layout.render(self, css_prefix: css) do
       Tilt.new(template('feature.haml')).render(self, file: feature_file)
      end

      output
    end

    def render_index(tree)
      @layout.render(self, css_prefix: 'css/') do
       Tilt.new(template('index.haml')).render(self, tree: tree.children.first)
      end
    end

    def render_partial(name, **kwargs)
      Tilt.new(template("_#{name}.haml")).render(self, **kwargs)
    end


    private

    def template(name)
      File.join(@template_path, name)
    end

  end
end