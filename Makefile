HOSTNAME := $(shell hostname -s)
UNAME_S	:= $(shell uname -s)
UNAME_M	:= $(shell uname -m)

ifeq ($(UNAME_S),Linux)
	TOOL := sudo nixos-rebuild
endif
ifeq ($(UNAME_S),Darwin)
	TOOL := darwin-rebuild
endif

ARGS :=

install: switch

build:
	$(TOOL) build --flake ./#$(HOSTNAME) $(ARGS)
	nvd diff /run/current-system result

boot:
	$(TOOL) boot --flake ./#$(HOSTNAME) $(ARGS) --show-trace

switch:
	$(TOOL) switch --flake ./#$(HOSTNAME) $(ARGS) --show-trace

switch-impure:
	$(TOOL) switch --flake ./#$(HOSTNAME) $(ARGS) --show-trace --impure

switch-debug: check
	$(TOOL) switch --flake ./#$(HOSTNAME) --option eval-cache false --show-trace $(ARGS)

switch-offline:
	$(TOOL) switch --flake ./#$(HOSTNAME) --option substitute false $(ARGS)

update:
	@nix flake update
	$(TOOL) switch --flake ./#$(HOSTNAME) --upgrade $(ARGS)

check:
	@nix flake check --show-trace $(ARGS)

test: check
	$(TOOL) dry-build --flake ./#$(HOSTNAME)

rollback:
	$(TOOL) switch --flake ./#$(HOSTNAME) --rollback

repl:
	nixos-repl
