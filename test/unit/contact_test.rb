require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  
  def setup
    @import = <<-IMPORT
Last	First	Cell Phone	E-mail
Jon	Doe	(123) 456-7890	jon.doe@example.com
Jane	Doe	(234) 567-8901	jane_doe@example.com
Foo	Bar	(345) 678-9012	foo+bar@example.com
IMPORT
  end
  
  test "parsing tab delimited-line separated" do
    actual = Contact.parse_tab_delimited(@import)
    
    expected = [
      {:name => 'Jon Doe', :telephone => '(123) 456-7890', :email => 'jon.doe@example.com'},
      {:name => 'Jane Doe', :telephone => '(234) 567-8901', :email => 'jane_doe@example.com'},
      {:name => 'Foo Bar', :telephone => '(345) 678-9012', :email => 'foo+bar@example.com'}
    ]
    assert_equal(expected, actual)
  end
  
  test "parsing nil" do
    Contact.parse_tab_delimited(nil)
    assert true
  end
end
