# Setup direnv
## Run direnv shell hook
eval "$(direnv hook bash)"

## Set direnv timeout warning to 2 minutes (default=20s)
export DIRENV_WARN_TIMEOUT=2m

# Setup sccache
## Set cache size
export SCCACHE_CACHE_SIZE="5G"

## Set cache directory
export SCCACHE_DIR="$HOME/.sccache/"

