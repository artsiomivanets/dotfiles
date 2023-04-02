apply:
	stow --restow --target=$$(echo $$HOME) */

delete:
	stow --delete --target=$$(echo $$HOME) */ 
