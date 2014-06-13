module ApplicationHelper
	def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == params[:sort_by] && params[:direction] == "ASC") ? "DESC" : "ASC"
    link_to title, movies_path(sort_by: column, direction: direction)
  end
  
end
