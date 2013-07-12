module Clivers
  module Helper
    module String
      def self.camelize(input)
        return nil if not input

        parts = input.split(/_/).map do |part|
          part.capitalize()
        end

        parts.join("")
      end

      def self.format_text(text, options = {})
        tokens = tokenize(text)
        tokens_to_lines(tokens, options)
      end

      def self.tokenize(text)
        text.scan(/([^\s]+)|(\n\r|\n|\r)|(\s+)/).map do |word, newline, space|
          case
          when word
            { :text => word, :type => :word }
          when newline
            { :text => newline, :type => :newline }
          when space && space =~ /^\s*$/
            { :text => space, :type => :space }
          end
        end
      end

      def self.tokens_to_lines(tokens, options = {})
        max_width = options[:max_width] || 80;
        indentation = options[:indentation] || ""
        preserve_paragraphs = options[:preserve_paragraphs] == nil ? true : options[:preserve_paragraphs]

        lines = []
        buffer = indentation

        newline_count = 0
        tokens.each do |token|
          type = token[:type]
          if type == :newline
            newline_count += 1
            next
          end

          if preserve_paragraphs and newline_count > 1
            for i in 1..newline_count
              lines << normalize_line(buffer)
              buffer = indentation
            end
          end

          newline_count = 0;
          text = type == :space ? " " : token[:text]
          potential_width = text.length() + buffer.length()
          if potential_width > max_width
            lines << normalize_line(buffer)
            buffer = indentation
          end

          buffer += text
        end

        lines << normalize_line(buffer)
        lines
      end

      def self.normalize_line(line, options = {})
        line.strip()
      end
    end
  end
end
