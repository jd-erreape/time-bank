namespace :test do

  # Way to load the lib folder when invoking rake test (also added rake test:lib task)
  desc 'Test lib source'
  Rake::TestTask.new(:lib) do |t|
    t.libs << 'test'
    t.pattern = 'test/lib/**/*_test.rb'
    t.verbose = false
  end

  # Execute only 'fast' tests
  desc 'Execute fast tests'
  Rake::TestTask.new(:fast) do |t|
    t.libs << 'test'
    t.pattern = 'test/{models,lib,helpers,mailers}/**/*_test.rb'
    t.verbose = false
  end

  # Execute only 'slow' tests
  desc 'Execute slow tests'
  Rake::TestTask.new(:slow) do |t|
    t.libs << 'test'
    t.pattern = 'test/{integration,controllers}/**/*_test.rb'
    t.verbose = false
  end
end

lib_task = Rake::Task['test:lib']
test_task = Rake::Task[:test]
test_task.enhance { lib_task.invoke }