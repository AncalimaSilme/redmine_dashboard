module Rdb::UI

  class Menu < Node
    def initialize(name, title, opts = {}, &block)
      @sections  = []
      @name      = name
      @title     = title
      @opts      = opts || {}
      @accesskey = opts[:accesskey] || nil

      super &block
    end

    def <<(node)
      @sections << node
    end

    def render_to(io)
      write_tag io, :div, class: 'menu' do |io|
        io.write link_to(@title, 'javascript:void(0);', class: 'rdb-menu-link', accesskey: @accesskey)
        write_tag io, :div, class: 'container' do |io|
          write_tag io, :div, class: 'container-wrapper' do |io|
            @sections.each{|s| s.render_to io }
          end
        end
      end
    end
  end
end
