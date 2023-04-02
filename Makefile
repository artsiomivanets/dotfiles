apply:
	stow --target=$$(echo $$HOME) */

delete:
	stow --delete --target=$$(echo $$HOME) */ 
