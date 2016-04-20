require 'rails_helper'

RSpec.describe "topics/new", type: :view do
  before(:each) do
    assign(:topic, Topic.new(
      :title => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new topic form" do
    render

    assert_select "form[action=?][method=?]", topics_path, "post" do

      assert_select "input#topic_title[name=?]", "topic[title]"

      assert_select "textarea#topic_description[name=?]", "topic[description]"
    end
  end
end
