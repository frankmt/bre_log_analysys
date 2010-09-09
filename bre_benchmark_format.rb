class BreBenchmarkFormat < RequestLogAnalyzer::FileFormat::Base
  
  # Example Line:
  # 2010-08-26 12:07:02,630 - 24243 [http-8080-4] [user_for_org@example.com GET /s/invoices/pod] INFO  au.com.aapt.awp.backend.bre.BrePerformanceBenchmark - [EnquireCustomer, {customerId=9001}] took [34] milliseconds
  
  line_definition :my_line_type do |line|
    line.regexp = /(.*)au.com.aapt.awp.backend.bre.BrePerformanceBenchmark[\s+-]+\[(.*)\]\stook\s\[(.*)\]/
    line.header = true
    line.footer = true
    line.captures << { :name => :start, :type => :string } 
    line.captures << { :name => :method_id, :type => :string } 
    line.captures << { :name => :call_duration, :type => :duration, :unit => :msec }
  end
  
  report do |analyze|
    analyze.frequency :method_id, :title => "Request locales", :line_type => :current_locale
  end
end