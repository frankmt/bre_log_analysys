class BreBenchmarkFormat < RequestLogAnalyzer::FileFormat::Base
  
  line_definition :my_line_type do |line|
    line.regexp = /My line looks something like: (.+)/
    line.captures << { :name => :looks_like, :type => :string }
  end
  
  report do |analyze|
    analyze.frequency :looks_like, :title => "Top 20 of looks like phrases", :amount=> 20
  end
end