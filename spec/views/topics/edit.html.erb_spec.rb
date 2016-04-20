require 'rails_helper'

RSpec.describe "topics/edit", type: :view do
  before(:each) do
    @topic = assign(:topic, Topic.create!(
      :title => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit topic form" do
    render

    assert_select "form[action=?][method=?]", topic_path(@topic), "post" do

      assert_select "input#topic_title[name=?]", "topic[title]"

      assert_select "textarea#topic_description[name=?]", "topic[description]"
    end
  end
end
