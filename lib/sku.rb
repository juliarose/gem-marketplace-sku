class SKU
  attr_accessor :defindex,
    :killstreak_tier,
    :particle,
    :wear,
    :skin,
    :australium,
    :festivized
  
  def initialize(defindex, quality)
    @defindex = defindex
    @quality = quality
  end
    
  def self.parse(str)
    attributes = str.split(';')
    
    raise "Not a valid SKU: #{str}" if attributes.length <= 1
    
    # the first attribute is the defindex
    defindex = attributes[0].to_i
    
    raise "Invalid defindex: #{attributes[0]}" if defindex.to_s != attributes[0]
    
    # the second is the quality
    quality = attributes[1].to_i
    
    raise "Invalid quality: #{attributes[1]}" if quality.to_s != attributes[1]
    
    sku = SKU.new(defindex, quality)
    maps = {
      'kt-' => :killstreak_tier,
      'u' => :particle,
      'w' => :wear,
      'pk' => :skin,
      'australium' => :australium,
      'uncraftable' => :uncraftable,
      'festive' => :festivized
    }
    
    # these keys are integers
    integer_keys = [
      :killstreak_tier,
      :particle,
      :wear_id,
      :skin
    ]
    
    pattern = Regexp.new(/^([A-z\-]+)(\d+)?$/)
    
    # loop through each attribute past the first 2, which are the defindex and quality
    attributes.drop(2).each do |attribute|
      match = attribute.match(pattern)
      
      if match
        name = match[1]
        value = match[2]
        key = maps[name]
        
        if key
          if integer_keys.include?(key)
            # the value should be expressed as an integer
            value_str = value
            value = value.to_i
            
            raise "Invalid attribute value: #{value_str}" if value.to_s != value_str
          else
            # otherwise the value is just a boolean (attribute exists)
            value = true
          end
          
          # add the attribute to the sku object
          sku.send("#{key}=", value)
        end
      end
    end
    
    sku
  end
end