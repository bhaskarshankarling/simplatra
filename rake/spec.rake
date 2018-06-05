desc 'Run specs'
task :spec do
    sh 'rspec -fd spec'
end