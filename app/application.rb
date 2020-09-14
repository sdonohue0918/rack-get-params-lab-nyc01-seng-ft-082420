class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.any?
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      else 
        resp.write "Your cart is empty"
      end
    elsif req.path.match(/add/)
      c_item = req.params["item"]

      if @@items.include?(c_item)
        @@cart << c_item
        resp.write "added #{c_item}"
      else
        resp.write "We don't have that item"
      end

    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  # def add(item_name)
  #   if @@items.include?(item_name)
  #     @@cart << item_name
  #   else
  #     return "We don't have that item"
  #   end
    
  # end


end
