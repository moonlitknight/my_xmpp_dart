The base of this repo is 95ee3f5 of https://github.com/vukoye/xmpp_dart

Afaik, this includes the null-safety changes and also WSS, however it doesn't work (see below).
it excludes the changes tagged for privacy lists.

### branch policy
My master is **mydev**. All features are branched off that, eg **muc** and merged back in.
**mydev** should always be stable and free of regression bugs.
To create a release, merge mydev into **release** with an appropriate tag and updated pubspec.yaml
My versioning begins with 10.4.1 to mirror the original repo if necessary.

### faults in 95ee3f5
All are documented in https://github.com/vukoye/xmpp_dart/issues/76 but basically:-
1. not setting tls to true
1. incorrectly swapping sockets during negotiation
1. bugs related to extending empty arrays during nonce creation

All fixed in 2f49b4e which also contains my bastardised Log class to log to console

