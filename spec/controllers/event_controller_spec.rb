require "spec_helper"

describe EventsController do

  describe "user logged in" do

    let(:current_user) { create(:user) }

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in current_user
      controller.stub(:current_user).and_return(current_user)
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

        it "saves object" do
          expect do
            event_params = {
              name: 'test name1',
              invite_only: true,
              duration: {
                start_date: DateTime.new(2014, 3, 7, 9, 0, 0),
                end_date: DateTime.new(2014, 3, 7, 11, 0, 0)
              }
            }

            post :create, event: event_params
          end.to change(Event, :count).by(1)
        end

      end

    end

    describe "PUT #update" do

      describe "with valid attributes" do
        before do
          @event = create(:event)
          current_user.update(event_id: @event.id)
          @event_params = @event.attributes
          @event_params["name"] = 'different event name'
          put :update, id: @event, event: @event_params
        end
        it 'updates object' do
         expect(@event.reload.name).to eq('different event name')
        end

        it "successfully redirect to events_path" do
          expect(response).to redirect_to(events_path)
        end

      end

      describe "with invalid attributes" do
        before do
          @event = create(:event)
          current_user.update(event_id: @event.id)
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
end
