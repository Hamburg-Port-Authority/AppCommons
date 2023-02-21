# AppCommons
Application Commons is a tool collection for plattform maintenance and support

TODO: write an introduction

# Assumption

This collection tools assume that you are working a structure close to our argocd stack.

TODO: write assumptions about the structure this collection of tools require to run


```console
.
├── cluster
│   └── <cluster-name>
│       ├── helm
│       ├── kustomize
│       └── seal-certificate
├── helm
│   └── message-broker
│       └── rabbitmq
├── instances
│   └── <installation_name>
│       └── values.yaml
├── kustomize
│   └── certfificate-issuer
│       ├── ca-issuer.yaml
│       └── kustomization.yaml
└── README.md
```