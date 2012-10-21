require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  
  def setup
    @import_last_first_phone_email = <<-IMPORT
Last	First	Cell Phone	E-mail
Jon	Doe	(123) 456-7890	jon.doe@example.com
Jane	Doe	(234) 567-8901	jane_doe@example.com
Foo	Bar	(345) 678-9012	foo+bar@example.com
IMPORT
    @import_name_telephone_email = <<-IMPORT
Name	Telephone	Email
Jon Doe	(123) 456-7890	jon.doe@example.com
Jane Doe	(234) 567-8901	jane_doe@example.com
Foo Bar	(345) 678-9012	foo+bar@example.com
IMPORT
    @import_email_telephone_name = <<-IMPORT
Email	Telephone	Name
jon.doe@example.com	(123) 456-7890	Jon Doe
jane_doe@example.com	(234) 567-8901	Jane Doe
foo+bar@example.com	(345) 678-9012	Foo Bar
IMPORT
  end
  
  test "parsing tab delimited-line separated" do
    actual = Contact.parse_tab_delimited(@import_last_first_phone_email)
    expected = [
      {:name => 'Jon Doe', :telephone => '(123) 456-7890', :email => 'jon.doe@example.com'},
      {:name => 'Jane Doe', :telephone => '(234) 567-8901', :email => 'jane_doe@example.com'},
      {:name => 'Foo Bar', :telephone => '(345) 678-9012', :email => 'foo+bar@example.com'}
    ]
    assert_equal(expected, actual)
    
    actual = Contact.parse_tab_delimited(@import_name_telephone_email)
    expected = [
      {:name => 'Jon Doe', :telephone => '(123) 456-7890', :email => 'jon.doe@example.com'},
      {:name => 'Jane Doe', :telephone => '(234) 567-8901', :email => 'jane_doe@example.com'},
      {:name => 'Foo Bar', :telephone => '(345) 678-9012', :email => 'foo+bar@example.com'}
    ]
    assert_equal(expected, actual)
    
    actual = Contact.parse_tab_delimited(@import_email_telephone_name)
    expected = [
      {:name => 'Jon Doe', :telephone => '(123) 456-7890', :email => 'jon.doe@example.com'},
      {:name => 'Jane Doe', :telephone => '(234) 567-8901', :email => 'jane_doe@example.com'},
      {:name => 'Foo Bar', :telephone => '(345) 678-9012', :email => 'foo+bar@example.com'}
    ]
    assert_equal(expected, actual)
  end
  
  test "parsing nil returns empty array" do
    actual = Contact.parse_tab_delimited(nil)
    expected = []
    assert_equal(expected, actual)
  end
end
