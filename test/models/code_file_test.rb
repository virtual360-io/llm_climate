require "test_helper"

class CodeFileTest < ActiveSupport::TestCase
  test "should set attributes on review" do
    code_file = CodeFile.new

    code_file.review = {
      "overall" => { "grade" => 1, "review" => "good" },
      "refactoring" => { "grade" => 2.2, "review" => "better" },
      "performance" => { "grade" => 3.5, "review" => "best" },
      "security" => { "grade" => 4, "review" => "great" }
    }

    assert_equal 1, code_file.overall_grade
    assert_equal "good", code_file.overall_review
    assert_equal 2.2, code_file.refactoring_grade
    assert_equal "better", code_file.refactoring_review
    assert_equal 3.5, code_file.performance_grade
    assert_equal "best", code_file.performance_review
    assert_equal 4, code_file.security_grade
    assert_equal "great", code_file.security_review
  end
end
