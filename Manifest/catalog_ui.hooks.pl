:- module(_, [], [ciaobld(bundlehooks), fsyntax]).

:- doc(title, "Bundle Hooks for catalog_ui").

:- use_module(engine(internals), ['$bundle_id'/1]).
:- use_module(library(aggregates), [findall/3]).
:- use_module(library(bundle/bundle_paths), [bundle_path/3]).
:- use_module(ciaobld(builder_aux), [update_file_from_clauses/3]).

'$builder_hook'(prepare_build_bin) :-
	ConfigFile = ~bundle_path(catalog_ui, 'src/catalog_ui_config_auto.pl'),
	update_file_from_clauses(~findall(C, emit_config(C)), ConfigFile, _).

emit_config(C) :-
	'$bundle_id'(ciaoviz),
	C = (:- compilation_fact(has_ciaoviz)).
