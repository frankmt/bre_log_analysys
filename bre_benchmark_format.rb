class BreBenchmarkFormat < RequestLogAnalyzer::FileFormat::Base
  
  #Example command
  # request-log-analyzer 
  #  --f ~/Documents/projects/tw/aapt/log_analysis/bre_benchmark_format.rb 
  #  ~/Documents/projects/tw/aapt/log_analysis/logs/catalina.out 
  #  --select path 'GET /s/home'
  
  # Example Line:
  # 2010-08-26 12:07:02,630 - 24243 [http-8080-4] [user_for_org@example.com GET /s/invoices/pod] INFO  au.com.aapt.awp.backend.bre.BrePerformanceBenchmark - [EnquireCustomer, {customerId=9001}] took [34] milliseconds
  
  line_definition :bre_benchmark_type do |line|
    line.regexp = /([\d\s\-\:]*)\,[\d\s\-]*\[.*\]\s+\[[\S@_\s\.]+((GET|POST)[\s\/a-zA-Z0-9]*)\].*au.com.aapt.awp.backend.bre.BrePerformanceBenchmark[\s+-]+\[(.*)\]\stook\s\[(.*)\]/
    line.header = true
    line.footer = true
    line.captures << { :name => :timestamp, :type => :timestamp } 
    line.captures << { :name => :path, :type => :string } 
    line.captures << { :name => :http_method, :type => :string } 
    line.captures << { :name => :method_id, :type => :string } 
    line.captures << { :name => :call_duration, :type => :duration, :unit => :msec }
  end
  
  report do |analyze|
    analyze.frequency :method_id, :title => "Method calls", :line_type => :bre_benchmark_type
    analyze.duration :call_duration, :title => "Duration of calls", :category => :method_id, :multiple => true
  end
end