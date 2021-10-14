control "gke" do 
  describe command('gcloud container clusters describe gke-terraform') do
    its('stdout') {should match (/name : gke-terraform/)}
  end
end 