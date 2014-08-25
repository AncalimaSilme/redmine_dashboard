class Rdb::BaseController < ::ApplicationController
  def check_read_permission
    unauthorized! unless board.readable_for? User.current
  end

  def check_write_permission
    unauthorized! unless board.writable_for? User.current
  end

  def unauthorized!
    render_404 # Do not leak if a board exists
  end
end
