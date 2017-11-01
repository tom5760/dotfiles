function kc --description 'alias kc=kubectl --kubeconfig=./kube_config'
	kubectl --kubeconfig=./kube_config $argv;
end
