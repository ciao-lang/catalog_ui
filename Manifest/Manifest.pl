:- bundle(catalog_ui).
version('0.1').
depends([
    core,
    wui
    % ciaoviz % TODO: make it optional
]).
alias_paths([catalog_ui = 'src']).
lib('src').
%
manual('catalog_ui', [main='doc/SETTINGS.pl']).
%
service(catalog_ui, [main='src/catalog_ui', actmod]).

