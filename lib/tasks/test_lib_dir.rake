# Way to load the lib folder when invoking rake test (also added rake test:lib task)
namespace :test do

  desc 'Test lib source'
  Rake::TestTask.new(:lib) do |t|    
    t.libs << 'test'
    t.pattern = 'test/lib/**/*_test.rb'
    t.verbose = false
  end

end

lib_task = Rake::Task['test:lib']
test_task = Rake::Task[:test]
test_task.enhance { lib_task.invoke }