# Gobetween


specialized gobetween Docker image

## GENERAL TIPS FOR Gobetween:
 * lower priority takes precedence  ( fallback )
 * higher weight uses a backend more often than others , but amngst its priority siblings

## USE_CASE: LDAP Fallback

### Situation:
   * gobetween ssl termination did not really work , even with SNI,
   * testing with curl -kLv ldaps://0.0.0.0:1234 helped to determine whether something gets through

### LDAP Solution
* mount your certs to /etc/letsencrypt
* in .env  , define:
   ```
   BINDPORT=6636
   PRIVKEY=/etc/letsencrypt/live/your.domain.lan/privkey.pem
   CERTPEM=/etc/letsencrypt/live/your.domain.lan/fullchain.pem
   ```

* socat will bind to BINDPORT and do ssl termination,
  you only need a "clean" tcp gobetween config listening on port 55555
* finally test against your new fail-over backend (univention example)
    `ldapsearch -x -LLL  -H ldaps://192.168.178.111:7636 -D uid=myuser.name,cn=users,dc=mydomain,dc=lan -w $psw  -b "dc=mydomain,dc=lan"|grep -e ^dn -e ^cn -e jectClass`
INSTALL/UPGRADE WITHOUT GIT: from parent of target: `curl https://gitlab.com/the-foundation/gobetween/-/archive/main/gobetween-main.tar.gz |tar xvz`
---

<h3>A project of the foundation</h3>
<a href="https://the-foundation.gitlab.io/"><div><img src="https://hcxi2.2ix.ch/gitlab/the-foundation/gotbetween/README.md/logo.jpg" width="480" height="270"/></div></a>


## Todo
- [ ] MORE DOCUMENTATION
- [ ] [Invite team members and collaborators](https://docs.gitlab.com/ee/user/project/members/)
- [ ] [Create a new merge request](https://docs.gitlab.com/ee/user/project/merge_requests/creating_merge_requests.html)
- [ ] [Automatically close issues from merge requests](https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically)
- [ ] [Enable merge request approvals](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/)
- [ ] [Automatically merge when pipeline succeeds](https://docs.gitlab.com/ee/user/project/merge_requests/merge_when_pipeline_succeeds.html)
