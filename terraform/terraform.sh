
# [T]erra[F]orm [P]lan
alias tfp='terraform plan -lock=false | tee tf_out.log && sed -n "/^Terraform will perform the following actions/,//p" tf_out.log | awk -F " " "/^\x1B\x5B\x31\x6D  # /{print \$0}"'

# [T]erra[F]orm [P]lan [F]AST
alias tfpf='terraform plan -lock=false -refresh=false | tee tf_out.log && sed -n "/^Terraform will perform the following actions/,//p" tf_out.log | awk -F " " "/^\x1B\x5B\x31\x6D  # /{print \$0}"'

# [T]erra[F]orm [P]lan [S]ummary - will just print the summary from tf_out.log without invoking plan itself
alias tfps='sed -n "/^Terraform will perform the following actions/,//p" tf_out.log | awk -F " " "/^\x1B\x5B\x31\x6D  # /{print \$0}"'

alias tfv='terraform validate'
