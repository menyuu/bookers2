module BooksHelper
  def sort_order(column, name)
    direction = (column == sort_column && sort_direction == 'asc') ? 'desc' : 'desc'
    link_to name, { sort: column, direction: direction}, remote: true
  end
end
