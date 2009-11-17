class TasksController < ApplicationController

  before_filter :find_task, :only => [:show, :edit, :update, :destroy,]
  before_filter :find_task_by_project, :only => [:in_work, :prioritize, :done, :in_backlog]
  def index
    @board = Board.find(params[:board_id])
    @tasks = Task.find(:all, :conditions =>['board_id = ? and state = ?', @board, params[:state]])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @board = Board.find(params[:board_id])
    @task = @board.tasks.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @board = Board.find(params[:board_id])
    @task = @board.tasks.build(params[:task])

    respond_to do |format|
      if @task.save
        flash[:notice] = 'Task was successfully created.'
        format.html { redirect_to board_task_url(@board, @task) }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def prioritize
    move_task_if_space(State::PRIORITIZED)
  end
  
  def in_work
    move_task_if_space(State::WORK)
  end
  
  def done
    set_state_and_redirect(State::DONE)
  end
  
  def in_backlog
    set_state_and_redirect(State::NEW)
  end
  
  def set_state_and_redirect(state)
    @task.state = state
    @task.save
    redirect_to board_url(@board)
  end
  
  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update

    respond_to do |format|
      if @task.update_attributes(params[:task])
        flash[:notice] = 'Task was successfully updated.'
        format.html { redirect_to board_task_url(@board, @task) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to board_path(@board) }
      format.xml  { head :ok }
    end
  end
  
  def find_task
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:id])
  end
  def find_task_by_project
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:project])
  end
  
  def move_task_if_space(state)
    if (no_free_space(state))
      redirect_to board_url(@board) 
    else
      set_state_and_redirect(state)
    end
  end
  
  def find_by_state_and_project(state, project)
    @board.tasks.find(:all, :conditions => ["state = ? and project = ?", state, project ])
  end
  
  def no_free_space(state)
    if (@task.project)
      projectlist = @board.find_by_state_and_project(state, @task.project) 
      if (projectlist.size >= @board.concurrentprojects)
        return true
      end
    end
    if (not @task.project)
      tasklist = @board.find_by_state_and_project(state, @task.project)
      if (tasklist.size >= @board.concurrenttasks)
        return true
      end
    end
    false
  end
end
