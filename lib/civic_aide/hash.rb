class Hash

  def rubyify_keys!
    keys.each do |k|
      val = self[k]
      # ignore Open Civic Data identifiers
      unless k[0..3] == "ocd-"
        delete(k)
        new_key = k.to_s.underscore
        self[new_key] = val
      end
      val.rubyify_keys! if val.is_a?(Hash)
      val.each{|p| p.rubyify_keys! if p.is_a?(Hash)} if val.is_a?(Array)
    end
    self
  end

  def except!(*keys)
    keys.each { |key| delete(key) }
    self
  end

  def change_zip!
    keys.each do |k|
      self["zipCode"] = self.delete "zip"  if k == "zip"
      self[k].change_zip! if self[k].is_a? Hash
      self[k].each{|p| p.change_zip! if p.is_a?(Hash)} if self[k].is_a?(Array)
    end
    self
  end

end