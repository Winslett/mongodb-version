require "mongodb/version/version"

module MongoDB

  class Version
    attr_reader :major, :minor, :patch, :special

    def initialize(version)
      raise "Nil versions are useless to me" if version.nil?

      @major, @minor, @patch, @special = version.match(/^([\d]+)\.([\d]+)\.([\d]+)(?:\-(.+))?$/).to_a[1..-1]

      @major = @major.to_i
      @minor = @minor.to_i
      @patch = @patch.to_i
    end

    def self.[](version)
      self.new(version)
    end

    def >(version)
      version = Version[version] unless version.is_a?(Version)
      self.major > version.major && self.minor > version.minor && self.patch > version.patch
    end

    def >(other)
      compare([:>, :>, :>], other)
    end

    def <(other)
      compare([:<, :<, :<], other)
    end

    def >=(other)
      compare([:>, :>, :>=], other)
    end

    def <=(other)
      compare([:<, :<, :<=], other)
    end

    def ==(other)
      compare([:==, :==, :==], other)
    end

    def ===(other)
      self == other && special == other.special
    end

    def compare(operators, other)
      other = Version[other] unless other.is_a?(Version)

      major.send(operators.shift, other.major) ||            # Major match method?
        ((major == other.major) &&                   # Major equal and further comparison?
            minor.send(operators.shift, other.minor) ||      # Minor match method?
              ((minor == other.minor) &&             # Minor equal and further comparison?
                  patch.send(operators.shift, other.patch))) # Patch match method?
    end

    def ttl_collections?
      self >= "2.2.0"
    end

    def authentication_schemes
      case
        when self < "2.4.0" then [1]
        when self >= "2.4.0" && self < "2.6.0" then [1, 2]
        when self >= "2.6.0" then [2]
      end
    end

    def text_search
      case
        when self >= "2.4.0" && self < "2.6.0" then :beta
        when self >= "2.6.0" then :production
      end
    end

    def text_search?
      !!text_search
    end
  end

end