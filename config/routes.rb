TpvSample::Application.routes.draw do
  get 'payments/new' => 'payments#new', as: 'new_payment'
  post 'payments/validate' => 'payments#validate', as: 'payment_validate'
  get  'payments/success' => 'payments#success', as: 'payment_success'
  get  'payments/failure' => 'payments#failure', as: 'payment_failure'
  root to: 'home#main'
end
