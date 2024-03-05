# CIS Compliance benchmark report
trivy k8s cluster --compliance=k8s-cis --report summary
trivy k8s cluster --compliance=k8s-cis --report summary > trivy_cis_compliace_report.txt

# NSA Compliance benchmark
trivy k8s cluster --compliance=k8s-nsa --report all
trivy k8s cluster --compliance=k8s-nsa --report all > trivy_nsa_compliace_report.txt

# PSS - Pod Security Standards, Baseline benchmark
trivy k8s cluster --compliance=k8s-pss-baseline --report summary
trivy k8s cluster --compliance=k8s-pss-baseline --report summary > trivy_pss_baseline_compliace_report.txt
