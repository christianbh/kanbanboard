class BoardsController < ApplicationController
  
  before_filter :find_board, :only => [:show, :edit, :update, :destroy]
  def index
    @boards = Board.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @boards }
    end
  end

  def show
    @prioritized_tasks = find_by_state_and_project(State::PRIORITIZED, false)
    @prioritized_projects = find_by_state_and_project(State::PRIORITIZED, true)
    @in_work_tasks = find_by_state_and_project(State::WORK, false)
    @in_work_projects = find_by_state_and_project(State::WORK, true)
    @new_tasks = find_by_state_and_project(State::NEW, false)
    @new_projects = find_by_state_and_project(State::NEW, true)
    fill_list(@in_work_tasks, @board.concurrenttasks)
    fill_list(@in_work_projects, @board.concurrentprojects)
    fill_list(@prioritized_tasks, @board.concurrenttasks)
    fill_list(@prioritized_projects, @board.concurrentprojects)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @board }
    end
  end

  def new
    @board = Board.new 
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @board }
    end
  end

  def edit
  end
  
  def create
    @board = Board.new(params[:board])
    respond_to do |format|
      if @board.save
        flash[:notice] = 'Board was successfully created.'
        format.html { redirect_to(@board) }
        format.xml  { render :xml => @board, :status => :created, :location => @board }
      else
        format.html {render :action => "new"}
        format.xml  { render :xml => @board.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def find_board
    @board = Board.find(params[:id])
  end
  
  def find_by_state_and_project(state, project)
    @board.tasks.find(:all, :conditions => ["state = ? and project = ?", state, project ])
  end
  
  def update
    
    respond_to do |format|
      if @board.update_attributes(params[:board])
        flash[:notice] = 'Board was successfully updated.'
        format.html { redirect_to(@board) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @board.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @board.destroy
    respond_to do |format|
      format.html { redirect_to(boards_url) }
      format.xml  { head :ok }
    end
  end
  
  def fill_list(list, limit)
    while list.size < limit do
      list.push(nil)
    end  
  end

end
