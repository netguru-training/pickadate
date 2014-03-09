require "spec_helper"

describe EventsController do


  describe "user logged in" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      sign_in user
    end
      
    describe "GET #index" do
      before do
        get :index
      end
      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
      end

      it "renders template index" do
        expect(response).to render_template('index')
      end
    end

    describe "POST #create" do
      describe "with valid attributes" do

        def post_action 
          @event_params = {
            name: 'test name1',
            invite_only: true,
            duration: {
              start_date: DateTime.new(2014, 3, 7, 9, 0, 0),
              end_date: DateTime.new(2014, 3, 7, 11, 0, 0)
            }
          }
          post :create, event: @event_params
        end


        it "saves object" do
          raise post_action.inspect
          expect(post_action).to change(Event.count)
        end

        it "successfully redirects to events_path" do
          post_action
          expect(response).to redirect_to(events_path)
        end

      end

    end

    describe "PUT #update" do

      describe "with valid attributes" do
        before do
          @event = create(:event)
          @event_params = @event.attributes
          @event_params[:name] = 'different event name'        
          put :update, id: @event, event: @event_params
          @event.reload
        end

        it 'updates object'do
         expect(@event.name).to eq('different event name')
        end

        it "successfully redirect to events_path" do
          expect(response).to redirect_to(events_path)
        end
      end

      describe "with invalid attributes" do
        before do
          @event = create(:event)
          @event_params = @event.attributes
          @event_params[:name] = 'aaa'        
          put :update, id: @event, event: @event_params
          @event.reload
        end

        it 'doesn\'t update object'do
         expect(@event.name).not_to eq('aaa')
        end

        it "renders edit template" do
          expect(response).to  render_template('edit')
        end
      end

    end

  end

  describe "user unlogged" do
    describe "GET #index" do
      it "responds successfully with an HTTP 200 status code" do
        get :index
        expect(response).not_to be_success
      end
    end
  end




    # it "renders the index template" do
    #   get :index
    #   expect(response).to render_template("index")
    # end

    # it "loads all of the posts into @posts" do
    #   post1, post2 = Post.create!, Post.create!
    #   get :index

    #   expect(assigns(:posts)).to match_array([post1, post2])
    # end
end