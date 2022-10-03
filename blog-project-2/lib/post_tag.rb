class PostTag
  attr_accessor :post_id, :tag_id

  def initialize
    @posts = []
    @tags = []
  end
end