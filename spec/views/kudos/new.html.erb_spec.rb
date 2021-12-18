require 'rails_helper'

RSpec.describe "kudos/new", type: :view do
  before(:each) do
    assign(:kudo, Kudo.new(
      title: "MyString",
      content: "MyText",
      employee: nil
    ))
  end

  it "renders new kudo form" do
    render

    assert_select "form[action=?][method=?]", kudos_path, "post" do

      assert_select "input[name=?]", "kudo[title]"

      assert_select "textarea[name=?]", "kudo[content]"

      assert_select "input[name=?]", "kudo[employee_id]"
    end
  end
end
