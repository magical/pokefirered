TILESETGFXDIR := data/tilesets
GLOBALGFXDIR := data/graphics
FONTGFXDIR := $(GLOBALGFXDIR)/fonts
FAMECHECKERGFXDIR := data/fame_checker
INTERFACEGFXDIR := graphics/interface
BTLANMSPRGFXDIR := graphics/battle_anims/sprites
UNUSEDGFXDIR := graphics/unused
UNKNOWNGFXDIR := graphics/unknown
BATINTGFXDIR := graphics/battle_interface
MASKSGFXDIR := graphics/battle_anims/masks
BATTRANSGFXDIR := graphics/battle_transitions
TYPESGFXDIR := graphics/types
RAYQUAZAGFXDIR := graphics/rayquaza_scene
ROULETTEGFXDIR := graphics/roulette
SLOTMACHINEGFXDIR := graphics/slot_machine
PKNAVGFXDIR := graphics/pokenav
PKNAVOPTIONSGFXDIR := graphics/pokenav/options
PSSGFXDIR := graphics/pokemon_storage
EVENTOBJGFXDIR := graphics/event_objects
MISCGFXDIR := graphics/misc
TEXTWINDOWGFXDIR := graphics/text_window
SLOTMACHINEGFXDIR := graphics/slot_machine
TEACHYTVGFXDIR := graphics/teachy_tv
SSANNEGFXDIR := graphics/ss_anne
ITEMPCGFXDIR := graphics/item_pc
TITLESCREENGFXDIR := graphics/title_screen

types := normal fight flying poison ground rock bug ghost steel mystery fire water grass electric psychic ice dragon dark
contest_types := cool beauty cute smart tough

CASTFORMGFXDIR := graphics/pokemon/castform
$(CASTFORMGFXDIR)/front.4bpp: $(CASTFORMGFXDIR)/normal/front.4bpp \
											$(CASTFORMGFXDIR)/sunny/front.4bpp \
											$(CASTFORMGFXDIR)/rainy/front.4bpp \
											$(CASTFORMGFXDIR)/snowy/front.4bpp
	@cat $^ >$@

$(CASTFORMGFXDIR)/back.4bpp: $(CASTFORMGFXDIR)/normal/back.4bpp \
									 $(CASTFORMGFXDIR)/sunny/back.4bpp \
									 $(CASTFORMGFXDIR)/rainy/back.4bpp \
									 $(CASTFORMGFXDIR)/snowy/back.4bpp
	@cat $^ >$@

$(CASTFORMGFXDIR)/normal.gbapal: $(CASTFORMGFXDIR)/normal/normal.gbapal \
									 $(CASTFORMGFXDIR)/sunny/normal.gbapal \
									 $(CASTFORMGFXDIR)/rainy/normal.gbapal \
									 $(CASTFORMGFXDIR)/snowy/normal.gbapal
	@cat $^ >$@

$(CASTFORMGFXDIR)/shiny.gbapal: $(CASTFORMGFXDIR)/normal/shiny.gbapal \
									$(CASTFORMGFXDIR)/sunny/shiny.gbapal \
									$(CASTFORMGFXDIR)/rainy/shiny.gbapal \
									$(CASTFORMGFXDIR)/snowy/shiny.gbapal
	@cat $^ >$@

$(FONTGFXDIR)/font0_latin.latfont: $(FONTGFXDIR)/font0_latin.png
	$(GFX) $< $@

$(FONTGFXDIR)/font0_jap.fwjpnfont: $(FONTGFXDIR)/font0_jap.png
	$(GFX) $< $@

$(FONTGFXDIR)/font1_latin.latfont: $(FONTGFXDIR)/font1_latin.png
	$(GFX) $< $@

$(FONTGFXDIR)/font1_jap.fwjpnfont: $(FONTGFXDIR)/font1_jap.png
	$(GFX) $< $@

$(FONTGFXDIR)/font2_latin.latfont: $(FONTGFXDIR)/font2_latin.png
	$(GFX) $< $@

$(FONTGFXDIR)/font2_jap.fwjpnfont: $(FONTGFXDIR)/font2_jap.png
	$(GFX) $< $@

$(FONTGFXDIR)/font4_latin.latfont: $(FONTGFXDIR)/font4_latin.png
	$(GFX) $< $@

$(FONTGFXDIR)/font4_jap.fwjpnfont: $(FONTGFXDIR)/font4_jap.png
	$(GFX) $< $@

$(FONTGFXDIR)/font5_latin.latfont: $(FONTGFXDIR)/font5_latin.png
	$(GFX) $< $@

$(FONTGFXDIR)/font5_jap.fwjpnfont: $(FONTGFXDIR)/font5_jap.png
	$(GFX) $< $@

$(FONTGFXDIR)/font6.fwjpnfont: $(FONTGFXDIR)/font6_braille.png
	$(GFX) $< $@

$(FONTGFXDIR)/font9_jap.fwjpnfont: $(FONTGFXDIR)/font9_jap.png
	$(GFX) $< $@

graphics/title_screen/pokemon_logo.gbapal: %.gbapal: %.pal
	$(GFX) $< $@ -num_colors 224

graphics/link_games/pkmnjump_bg.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 63

graphics/pokenav/region_map.8bpp: %.8bpp: %.png
	$(GFX) $< $@ -num_tiles 233

$(MISCGFXDIR)/japanese_hof.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 29

$(INTERFACEGFXDIR)/menu.gbapal: $(INTERFACEGFXDIR)/menu_0.gbapal \
						$(INTERFACEGFXDIR)/menu_1.gbapal
	@cat $^ >$@

$(BTLANMSPRGFXDIR)/010.4bpp: $(BTLANMSPRGFXDIR)/010_0.4bpp \
						  $(BTLANMSPRGFXDIR)/010_1.4bpp \
						  $(BTLANMSPRGFXDIR)/010_2.4bpp \
						  $(BTLANMSPRGFXDIR)/010_3.4bpp
	@cat $^ >$@

$(UNUSEDGFXDIR)/obi_palpak1.gbapal: $(UNUSEDGFXDIR)/old_pal1.gbapal \
									$(UNUSEDGFXDIR)/old_pal2.gbapal \
									$(UNUSEDGFXDIR)/old_pal3.gbapal
	@cat $^ >$@

$(UNUSEDGFXDIR)/obi_palpak3.gbapal: $(UNUSEDGFXDIR)/old_pal5.gbapal \
									$(UNUSEDGFXDIR)/old_pal6.gbapal \
									$(UNUSEDGFXDIR)/old_pal7.gbapal
	@cat $^ >$@

$(UNUSEDGFXDIR)/obi1.4bpp: $(UNUSEDGFXDIR)/old_bulbasaur.4bpp \
						   $(UNUSEDGFXDIR)/old_charizard.4bpp
	@cat $^ >$@

$(UNUSEDGFXDIR)/obi2.4bpp: $(UNUSEDGFXDIR)/old_bulbasaur2.4bpp \
						   $(UNUSEDGFXDIR)/old_battle_interface_1.4bpp \
						   $(UNUSEDGFXDIR)/old_battle_interface_2.4bpp \
						   $(UNUSEDGFXDIR)/old_battle_interface_3.4bpp
	@cat $^ >$@

$(INTERFACEGFXDIR)/hp_numbers.4bpp: $(INTERFACEGFXDIR)/hpbar_anim.4bpp \
							$(INTERFACEGFXDIR)/numbers1.4bpp \
							$(INTERFACEGFXDIR)/numbers2.4bpp
	@cat $^ >$@

$(UNUSEDGFXDIR)/redyellowgreen_frame.bin: $(UNUSEDGFXDIR)/red_frame.bin \
										  $(UNUSEDGFXDIR)/yellow_frame.bin \
										  $(UNUSEDGFXDIR)/green_frame.bin \
										  $(UNUSEDGFXDIR)/blank_frame.bin
	@cat $^ >$@

$(UNUSEDGFXDIR)/color_frames.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 353

$(BATINTGFXDIR)/unused_window2bar.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 5

$(UNUSEDGFXDIR)/old_contest.4bpp: $(UNUSEDGFXDIR)/old_contest_frame_1.4bpp \
								  $(UNUSEDGFXDIR)/old_contest_floor.4bpp \
								  $(UNUSEDGFXDIR)/old_contest_frame_2.4bpp \
								  $(UNUSEDGFXDIR)/old_contest_symbols.4bpp \
								  $(UNUSEDGFXDIR)/old_contest_meter.4bpp \
								  $(UNUSEDGFXDIR)/old_contest_classes.4bpp \
								  $(UNUSEDGFXDIR)/old_contest_numbers.4bpp
	@cat $^ >$@

$(UNUSEDGFXDIR)/old_contest_2.4bpp: $(UNUSEDGFXDIR)/old_contest_2_1.4bpp \
									$(UNUSEDGFXDIR)/old_contest_2_2.4bpp
	@cat $^ >$@

$(UNKNOWNGFXDIR)/unknown_D196E4.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 36

$(BTLANMSPRGFXDIR)/141.4bpp: $(BTLANMSPRGFXDIR)/141_0.4bpp \
						  $(BTLANMSPRGFXDIR)/141_1.4bpp \
						  $(BTLANMSPRGFXDIR)/141_2.4bpp \
						  $(BTLANMSPRGFXDIR)/141_3.4bpp \
						  $(BTLANMSPRGFXDIR)/141_4.4bpp
	@cat $^ >$@

$(BTLANMSPRGFXDIR)/074.4bpp: $(BTLANMSPRGFXDIR)/074_0.4bpp \
						  $(BTLANMSPRGFXDIR)/074_1.4bpp
	@cat $^ >$@

$(BTLANMSPRGFXDIR)/159.4bpp: $(BTLANMSPRGFXDIR)/159_0.4bpp \
						  $(BTLANMSPRGFXDIR)/159_1.4bpp
	@cat $^ >$@

$(BTLANMSPRGFXDIR)/001.4bpp: $(BTLANMSPRGFXDIR)/001_0.4bpp \
						  $(BTLANMSPRGFXDIR)/001_1.4bpp
	@cat $^ >$@

$(MASKSGFXDIR)/unknown_D2EC24.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 14

$(BATTRANSGFXDIR)/vs_frame.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 16

$(INTERFACEGFXDIR)/party_menu_misc.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 62

$(TYPESGFXDIR)/move_types.4bpp: $(types:%=$(TYPESGFXDIR)/%.4bpp) $(contest_types:%=$(TYPESGFXDIR)/contest_%.4bpp)
	@cat $^ >$@

$(TYPESGFXDIR)/move_types.gbapal: $(TYPESGFXDIR)/move_types_1.gbapal \
							   $(TYPESGFXDIR)/move_types_2.gbapal \
							   $(TYPESGFXDIR)/move_types_3.gbapal
	@cat $^ >$@

$(INTERFACEGFXDIR)/bag_screen.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 53

$(RAYQUAZAGFXDIR)/rayquaza.8bpp: %.8bpp: %.png
	$(GFX) $< $@ -num_tiles 227

$(RAYQUAZAGFXDIR)/overcast.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 313

$(RAYQUAZAGFXDIR)/rayquaza_fly1.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 124

$(RAYQUAZAGFXDIR)/rayquaza_tail_fix.4bpp: $(RAYQUAZAGFXDIR)/rayquaza_tail.4bpp
	cp $< $@
	head -c 12 /dev/zero >> $@

$(RAYQUAZAGFXDIR)/chase_streaks.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 19

$(RAYQUAZAGFXDIR)/rayquaza_chase.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 155

graphics/picture_frame/frame5.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 86

$(ROULETTEGFXDIR)/roulette_tilt.4bpp: $(ROULETTEGFXDIR)/shroomish.4bpp \
									  $(ROULETTEGFXDIR)/tailow.4bpp
	@cat $^ >$@

$(ROULETTEGFXDIR)/poke_icons2.4bpp: $(ROULETTEGFXDIR)/wynaut.4bpp \
									$(ROULETTEGFXDIR)/azurill.4bpp \
									$(ROULETTEGFXDIR)/skitty.4bpp \
									$(ROULETTEGFXDIR)/makuhita.4bpp
	@cat $^ >$@

$(BATTRANSGFXDIR)/85BBC14.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 53

$(BATTRANSGFXDIR)/rayquaza.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 938

$(BATTRANSGFXDIR)/frontier_square_1.4bpp: $(BATTRANSGFXDIR)/frontier_squares_blanktiles.4bpp \
										 $(BATTRANSGFXDIR)/frontier_squares_1.4bpp
	@cat $^ >$@

$(BATTRANSGFXDIR)/frontier_square_2.4bpp: $(BATTRANSGFXDIR)/frontier_squares_blanktiles.4bpp \
										 $(BATTRANSGFXDIR)/frontier_squares_2.4bpp
	@cat $^ >$@
 
$(BATTRANSGFXDIR)/frontier_square_3.4bpp: $(BATTRANSGFXDIR)/frontier_squares_blanktiles.4bpp \
										 $(BATTRANSGFXDIR)/frontier_squares_3.4bpp
	@cat $^ >$@

$(BATTRANSGFXDIR)/frontier_square_4.4bpp: $(BATTRANSGFXDIR)/frontier_squares_blanktiles.4bpp \
										 $(BATTRANSGFXDIR)/frontier_squares_4.4bpp
	@cat $^ >$@

$(SLOTMACHINEGFXDIR)/reel_time_gfx.4bpp: $(SLOTMACHINEGFXDIR)/reel_time_pikachu.4bpp \
										 $(SLOTMACHINEGFXDIR)/reel_time_machine.4bpp
	@cat $^ >$@

$(UNUSEDGFXDIR)/intro_birch_beauty.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 822

$(PSSGFXDIR)/forest_frame.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 55

$(PSSGFXDIR)/forest.4bpp: $(PSSGFXDIR)/forest_frame.4bpp $(PSSGFXDIR)/forest_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/city_frame.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 52

$(PSSGFXDIR)/city.4bpp: $(PSSGFXDIR)/city_frame.4bpp $(PSSGFXDIR)/city_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/desert.4bpp: $(PSSGFXDIR)/desert_frame.4bpp $(PSSGFXDIR)/desert_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/savanna_frame.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 45

$(PSSGFXDIR)/savanna_bg.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 23

$(PSSGFXDIR)/savanna.4bpp: $(PSSGFXDIR)/savanna_frame.4bpp $(PSSGFXDIR)/savanna_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/crag_frame.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 49

$(PSSGFXDIR)/crag.4bpp: $(PSSGFXDIR)/crag_frame.4bpp $(PSSGFXDIR)/crag_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/volcano_frame.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 56

$(PSSGFXDIR)/volcano.4bpp: $(PSSGFXDIR)/volcano_frame.4bpp $(PSSGFXDIR)/volcano_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/snow_frame.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 57

$(PSSGFXDIR)/snow.4bpp: $(PSSGFXDIR)/snow_frame.4bpp $(PSSGFXDIR)/snow_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/cave_frame.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 55

$(PSSGFXDIR)/cave.4bpp: $(PSSGFXDIR)/cave_frame.4bpp $(PSSGFXDIR)/cave_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/beach_frame.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 46

$(PSSGFXDIR)/beach_bg.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 23

$(PSSGFXDIR)/beach.4bpp: $(PSSGFXDIR)/beach_frame.4bpp $(PSSGFXDIR)/beach_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/seafloor_frame.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 54

$(PSSGFXDIR)/seafloor.4bpp: $(PSSGFXDIR)/seafloor_frame.4bpp $(PSSGFXDIR)/seafloor_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/river_frame.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 51

$(PSSGFXDIR)/river_bg.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 11

$(PSSGFXDIR)/river.4bpp: $(PSSGFXDIR)/river_frame.4bpp $(PSSGFXDIR)/river_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/sky_frame.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 45

$(PSSGFXDIR)/sky.4bpp: $(PSSGFXDIR)/sky_frame.4bpp $(PSSGFXDIR)/sky_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/polkadot_frame.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 54

$(PSSGFXDIR)/polkadot.4bpp: $(PSSGFXDIR)/polkadot_frame.4bpp $(PSSGFXDIR)/polkadot_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/pokecenter_frame.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 35

$(PSSGFXDIR)/pokecenter.4bpp: $(PSSGFXDIR)/pokecenter_frame.4bpp $(PSSGFXDIR)/pokecenter_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/machine_frame.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 33

$(PSSGFXDIR)/machine.4bpp: $(PSSGFXDIR)/machine_frame.4bpp $(PSSGFXDIR)/machine_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/plain_frame.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 18

$(PSSGFXDIR)/plain.4bpp: $(PSSGFXDIR)/plain_frame.4bpp $(PSSGFXDIR)/plain_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/friends_frame1.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 57

$(PSSGFXDIR)/friends_frame2.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 57

$(PSSGFXDIR)/zigzagoon.4bpp: $(PSSGFXDIR)/friends_frame1.4bpp $(PSSGFXDIR)/zigzagoon_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/screen.4bpp: $(PSSGFXDIR)/friends_frame1.4bpp $(PSSGFXDIR)/screen_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/horizontal.4bpp: $(PSSGFXDIR)/friends_frame1.4bpp $(PSSGFXDIR)/horizontal_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/diagonal.4bpp: $(PSSGFXDIR)/friends_frame1.4bpp $(PSSGFXDIR)/diagonal_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/block.4bpp: $(PSSGFXDIR)/friends_frame1.4bpp $(PSSGFXDIR)/block_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/ribbon.4bpp: $(PSSGFXDIR)/friends_frame1.4bpp $(PSSGFXDIR)/ribbon_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/pokecenter2.4bpp: $(PSSGFXDIR)/friends_frame1.4bpp $(PSSGFXDIR)/pokecenter2_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/frame.4bpp: $(PSSGFXDIR)/friends_frame1.4bpp $(PSSGFXDIR)/frame_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/blank.4bpp: $(PSSGFXDIR)/friends_frame1.4bpp $(PSSGFXDIR)/blank_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/circles.4bpp: $(PSSGFXDIR)/friends_frame1.4bpp $(PSSGFXDIR)/circles_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/azumarill.4bpp: $(PSSGFXDIR)/friends_frame2.4bpp $(PSSGFXDIR)/azumarill_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/pikachu.4bpp: $(PSSGFXDIR)/friends_frame2.4bpp $(PSSGFXDIR)/pikachu_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/legendary.4bpp: $(PSSGFXDIR)/friends_frame2.4bpp $(PSSGFXDIR)/legendary_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/dusclops.4bpp: $(PSSGFXDIR)/friends_frame2.4bpp $(PSSGFXDIR)/dusclops_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/ludicolo.4bpp: $(PSSGFXDIR)/friends_frame2.4bpp $(PSSGFXDIR)/ludicolo_bg.4bpp
	@cat $^ >$@

$(PSSGFXDIR)/whiscash.4bpp: $(PSSGFXDIR)/friends_frame2.4bpp $(PSSGFXDIR)/whiscash_bg.4bpp
	@cat $^ >$@

$(EVENTOBJGFXDIR)/pics/effects/unknown_4F6D38/0.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 11

$(INTERFACEGFXDIR)/selector_outline.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 8
	
$(BATTRANSGFXDIR)/frontier_transition.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 43

graphics/tm_case/unk_8E845D8.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 91
	
$(PKNAVOPTIONSGFXDIR)/options.4bpp: $(PKNAVOPTIONSGFXDIR)/hoenn_map.4bpp \
								$(PKNAVOPTIONSGFXDIR)/condition.4bpp \
								$(PKNAVOPTIONSGFXDIR)/match_call.4bpp \
								$(PKNAVOPTIONSGFXDIR)/ribbons.4bpp \
								$(PKNAVOPTIONSGFXDIR)/switch_off.4bpp \
								$(PKNAVOPTIONSGFXDIR)/party.4bpp \
								$(PKNAVOPTIONSGFXDIR)/search.4bpp \
								$(PKNAVOPTIONSGFXDIR)/cool.4bpp \
								$(PKNAVOPTIONSGFXDIR)/beauty.4bpp \
								$(PKNAVOPTIONSGFXDIR)/cute.4bpp \
								$(PKNAVOPTIONSGFXDIR)/smart.4bpp \
								$(PKNAVOPTIONSGFXDIR)/tough.4bpp \
								$(PKNAVOPTIONSGFXDIR)/cancel.4bpp
	@cat $^ >$@

$(PKNAVGFXDIR)/header.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 53

$(PKNAVGFXDIR)/outline.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 53
	
$(PKNAVGFXDIR)/ui_matchcall.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 13

$(INTERFACEGFXDIR)/region_map.8bpp: %.8bpp: %.png
	$(GFX) $< $@ -num_tiles 232

$(INTERFACEGFXDIR)/region_map_affine.8bpp: %.8bpp: %.png
	$(GFX) $< $@ -num_tiles 233

$(MISCGFXDIR)/birch_help.4bpp: $(MISCGFXDIR)/birch_bag.4bpp $(MISCGFXDIR)/birch_grass.4bpp
	@cat $^ >$@
	
$(FAMECHECKERGFXDIR)/img_845cf00.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 15

$(GLOBALGFXDIR)/fame_checker_bg.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 165

data/seagallop/water.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 41

$(MISCGFXDIR)/unk_846B008.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -mwidth 4 -mheight 4

$(TEXTWINDOWGFXDIR)/unk_8470B0C.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 19

$(SLOTMACHINEGFXDIR)/unk_8466620.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 66

$(SLOTMACHINEGFXDIR)/unk_84659d0.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 138

$(TEACHYTVGFXDIR)/tiles.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 233

$(SSANNEGFXDIR)/unk_8479A38.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 17

$(ITEMPCGFXDIR)/unk_8E85090.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 82

$(TITLESCREENGFXDIR)/unk_8ead608.4bpp: %.4bpp: %.png
	$(GFX) $< $@ -num_tiles 135
