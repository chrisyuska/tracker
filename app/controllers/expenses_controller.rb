class ExpensesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admins_only, :only => [:destroy]
  before_filter :set_categories

  # GET /expenses
  # GET /expenses.xml
  def index
    #TODO: Sort by created_by is not working for some reason...
    @expenses = Expense.joins(:user).sort{ |x,y| x[:created_by] <=> y[:created_by] }
    @total = 0
    @expenses.each do |e|
      if e.cost == "Expense"
        e.amount = -1 * e.amount.to_d
      end
      @total += e.amount
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @expenses }
    end
  end

  # GET /expenses/1
  # GET /expenses/1.xml
  def show
    @expense = Expense.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @expense }
    end
  end

  # GET /expenses/new
  # GET /expenses/new.xml
  def new
    @expense = Expense.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @expense }
    end
  end

  # GET /expenses/1/edit
  def edit
    @expense = Expense.find(params[:id])
    if (current_user.id != @expense.created_by)
      redirect_to(expenses_path, :notice => "That's not yours...")
    end
  end

  # POST /expenses
  # POST /expenses.xml
  def create
    @expense = Expense.new(params[:expense])

    respond_to do |format|
      if @expense.save
        format.html { redirect_to(expenses_path, :notice => 'Expense was successfully created.') }
        format.xml  { render :xml => @expense, :status => :created, :location => @expense }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @expense.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /expenses/1
  # PUT /expenses/1.xml
  def update
    @expense = Expense.find(params[:id])
    
    if (current_user.id != @expense.created_by)
      redirect_to(expenses_path, :notice => "That's not yours...")
    end
    
    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        format.html { redirect_to(expenses_path, :notice => 'Expense was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @expense.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.xml
  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to(expenses_url) }
      format.xml  { head :ok }
    end
  end

  private
  def set_categories
    @categories = Category.all
  end
end
