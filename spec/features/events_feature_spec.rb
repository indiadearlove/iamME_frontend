require 'rails_helper'

feature 'Event' do

  context 'When I want to create an event' do

    scenario 'I can fill in a form to do so' do
      user = create(:user) 
      create(:calendar, user: user)
      login_as(user)
      visit "/users/#{user.id}/events/new"

      attrs = attributes_for(:event)
      fill_in_event_form(attrs)

      attach_file('Image', "#{Rails.root}/spec/support/uploads/spiderman.jpg")
      click_button 'Create Event'

      expect(page).to have_content(attrs[:name])
    end

    scenario 'I have to upload an image' do
      user = create(:user)
      login_as(user)
      visit "/users/#{user.id}/events/new"

      fill_form(:event, {  name: 'Party', 'event_date_1i' => '2015',
                          'event_date_2i'=>'March', 'event_date_3i'=>'2',
                          'event_date_4i'=>'12',
                          'event_description'=>'Why is this happening?',
                          'event_location'=>   'Hyde Park' })

      click_button 'Create Event'
      expect(page).not_to have_content 'Party'
    end
  end
end



