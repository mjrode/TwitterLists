module Less
  class Retry
    def self.run(n, options = {})
      if n.is_a?(Enumerator)
        n = n.max + 1
      end
      exceptions = options[:rescuing] ? [ options[:rescuing] ].flatten : [RuntimeError]
      attempt = 0
      exs = {}
      begin
        attempt += 1
        yield
      rescue => e
        exs[Time.now.to_s(:db)] = "#{e.class.to_s}: #{e.message}"
        if exceptions.member?(e.class) && attempt < n
          sleep(options[:delay] || 2)
          retry 
        else
          Honeybadger.context(exs: exs)
          raise e
        end
      end
    end
  end
end