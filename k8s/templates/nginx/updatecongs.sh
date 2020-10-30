
gcloud container clusters get-credentials machine --zone us-central1-c --project st2dio
kubectl --context=gke_st2dio_us-central1-c_machine -nblogs delete cm nginx-conf
kubectl --context=gke_st2dio_us-central1-c_machine -nblogs create cm nginx-conf --from-file=nginx.dragon.conf --from-file=nginx.invest.conf --from-file=nginx.learning2love.conf --from-file=nginx.redsky.conf --from-file=nginx.ezeesluts.conf --from-file=nginx.aurora.conf --from-file=nginx.autoblogger.conf --from-file=nginx.s3sites.conf --from-file=nginx.s3sites2.conf

 kubectl --context=gke_st2dio_us-central1-c_machine -n blogs get po | grep nginx | cut -d' ' -f1 | xargs kubectl -n blogs delete po


gcloud container clusters get-credentials intranet --zone us-central1-c --project st2dio
kubectl -nblogs delete cm nginx-conf-admin
kubectl -nblogs create cm nginx-conf-admin --from-file=nginx.dragon.conf --from-file=nginx.invest.conf --from-file=nginx.learning2love.conf --from-file=nginx.redsky.conf --from-file=nginx.ezeesluts.conf --from-file=nginx.aurora.conf --from-file=nginx.autoblogger.conf --from-file=nginx.adserv.conf



 kubectl -n blogs get po | grep nginx | cut -d' ' -f1 | xargs kubectl -n blogs delete po

