class Parser
  
  def parse
    
    data = Hash.new
    attributes = sku.split(';')
    # the first attribute is the defindex
    defindex = attributes[0].to_i
    # the second is the quality
    quality_id = attributes[1].to_i
    # fetch the item to get more details for this item (its item name)
    item = Item.find_by_defindex(defindex)
    item_name = item.item_name
    # placeholder
    skin_name = nil
    
    maps = {
      'kt-' => 'killstreak_tier_id',
      'u' => 'particle_id',
      'w' => 'wear_id',
      'pk' => 'skin_id',
      'australium' => 'australium',
      'uncraftable' => 'uncraftable',
      'festive' => 'festive'
    }
    # these keys are integers
    integer_keys = [
      'killstreak_tier_id',
      'particle_id',
      'wear_id',
      'skin_id'
    ]
    
    # loop through each attribute past the first 2, which are the defindex and quality
    attributes.drop(2).each do |attribute|
      pattern = Regexp.new(/^([A-z\-]+)(\d+)?$/)
      match = attribute.match(pattern)
      
      if match
        name = match[1]
        value = match[2]
        key = maps[name]
        
        if key
          if integer_keys.include?(key)
            # the value should be expressed as an integer
            value = value.to_i
          else
            # otherwise the value is just a boolean (attribute exists)
            value = true
          end
          
          # add the attribute to the data object
          data[key] = value
        end
      end
    end
    
    if data['wear_id'] && full_name
      # we take the skin name from the full name
      skin_name = parse_skin_name(full_name, item_name)
    end
    
    {
      :defindex => defindex,
      :craftable => !data['uncraftable'],
      :quality => quality
    }.merge(data.symbolize_keys)
  end
end