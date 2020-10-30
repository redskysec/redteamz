commit_hash=${BUILDTAG:-`git rev-parse --short HEAD`}
#app=taiga
#base=us.gcr.io/bazaarlevel/$(taiga)
branch=${BRANCH_NAME:-`git rev-parse --abbrev-ref HEAD`}
image=$(base):$(shorthash)
template=ANSIBLE_HASH_BEHAVIOUR=merge ANSIBLE_JINJA2_EXTENSIONS=jinja2.ext.do \
ANSIBLE_ACTION_PLUGINS=/toolbox/plugins/actions `which python3` `which ansible-playbook` -e "basedir=${CURDIR}"  -e "context=${BRANCH_NAME}"  -e "env=${BRANCH_NAME}" \
-e "diff_id=${commit_hash}" -e "buildtag=${BUILDTAG}" -i /dev/null ~/dev/toolbox/playbooks/template.yaml 

clean:
	@rm -r tmp-k8s/



#template-local:
#	$(template) -e "env=$(branch)"  -vvvv

#template-canary:
#	$(template) -e "env=canary"   

#template-development:
#	$(template) -e "env=development"   


# For example: make context=cst2 template
#template:
#	$(template) -e "env=$(branch)" 


template-without-secrets:
	$(template) --tags=no_secrets

deploy:
	bash scripts/deployer
