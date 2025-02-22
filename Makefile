.SILENT:

# OS detection
OS = $(shell uname)
ifeq ($(OS), Linux)
    MLX_DIR = minilibx/minilinux
    LINKS = -lX11 -lXext
else
    MLX_DIR = minilibx/minimac
    LINKS = -framework OpenGL -framework AppKit
endif
MLX_LINK = $(MLX_DIR)/libmlx.a $(LINKS)

CC = cc
CFLAGS = -Wall -Wextra -Werror #-fsanitize=address -g3

# Variables
NAME = cub3d
SRC_DIR = srcs/
SUB_DIRS = raycasting/ utils/ parsing/ hooks/ debug/
OBJ_DIR = obj/
INCLUDE = includes/cub3d.h

BNS_NAME = cub3d_bonus
BNS_SRC_DIR = bns_srcs/
BNS_OBJ_DIR = bns_obj/
BNS_INCLUDE = includes/cub3d_bonus.h

# Source files
SRC = arg_parser.c \
	  main.c \
      handle_keys.c \
      extension_parser.c \
      structure_initialization.c \
      initialization_utils.c \
      parser.c \
      parse_data.c \
      parse_colors.c \
      parse_map.c \
      parse_player.c \
      fill_assets.c \
      ft_access.c \
      ft_array_clear.c \
      ft_array_add_back.c \
      ft_array_print.c \
      ft_arraylen.c \
      ft_atoi.c \
      ft_bzero.c \
      ft_error.c \
      ft_calloc.c \
      ft_memset.c \
      ft_putstr_fd.c \
      ft_split.c \
      ft_strchr.c \
      ft_strrchr.c \
      ft_strdup.c \
      ft_strlcpy.c \
      ft_strlen.c \
      get_next_line.c \
      ft_substr.c \
      ft_put_pixel_on_img.c \
      ft_strncmp.c \
      is_valid_charset.c \
      ft_isdigit.c \
      is_valid_pos.c \
      debug_file_input.c \
      key_detector.c \
      raycast.c \
      handle_player.c \
      draw_texture.c \
      compute_dda.c \
      wall_dist.c

BNS_SRC = main_bonus.c \
	handle_keys_bonus.c \
	arg_parser_bonus.c \
	extension_parser_bonus.c \
	structure_initialization_bonus.c \
	initialization_utils_bonus.c \
	parser_bonus.c \
	parse_data_bonus.c \
	parse_colors_bonus.c \
	parse_map_bonus.c \
	parse_player_bonus.c \
	fill_assets_bonus.c \
	bresenham_bonus.c \
	ft_access_bonus.c \
	ft_array_clear_bonus.c \
	ft_array_add_back_bonus.c \
	ft_array_print_bonus.c \
	ft_arraylen_bonus.c \
	ft_atoi_bonus.c \
	ft_bzero_bonus.c \
	ft_error_bonus.c \
	ft_calloc_bonus.c \
	ft_memset_bonus.c \
	ft_putstr_fd_bonus.c \
	ft_split_bonus.c \
	ft_strchr_bonus.c \
	ft_strrchr_bonus.c \
	ft_strdup_bonus.c \
	ft_strlcpy_bonus.c \
	ft_strlen_bonus.c \
	get_next_line_bonus.c \
	ft_substr_bonus.c \
	ft_put_pixel_on_img_bonus.c \
	ft_strncmp_bonus.c \
	is_valid_charset_bonus.c \
	ft_isdigit_bonus.c \
	is_valid_pos_bonus.c \
	debug_file_input_bonus.c \
	key_detector_bonus.c \
	raycast_bonus.c \
	handle_player_bonus.c \
	draw_texture_bonus.c \
	map_bonus.c \
	compute_dda_bonus.c \
	wall_dist_bonus.c


# Object files corresponding to source files
OBJ = $(addprefix $(OBJ_DIR),$(SRC:.c=.o))

BNS_OBJ = $(addprefix $(BNS_OBJ_DIR),$(BNS_SRC:.c=.o))

# vpath setup to find source files
vpath %.c $(SRC_DIR) $(BNS_SRC_DIR) $(foreach subfolder, $(SUB_DIRS), $(SRC_DIR)$(subfolder)) $(foreach subfolder, $(SUB_DIRS), $(BNS_SRC_DIR)$(subfolder))

# Rules
all: $(NAME)

bonus: $(BNS_NAME)

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(BNS_OBJ_DIR):
	mkdir -p $(BNS_OBJ_DIR)

$(NAME): $(OBJ_DIR) $(OBJ) $(MLX_DIR)/libmlx.a
	$(CC) $(CFLAGS) -I $(INCLUDE) $(OBJ) $(MLX_LINK) -o $(NAME)

$(BNS_NAME): $(BNS_OBJ_DIR) $(BNS_OBJ) $(MLX_DIR)/libmlx.a
	$(CC) $(CFLAGS) -I $(BNS_INCLUDE) $(BNS_OBJ) $(MLX_LINK) -o $(BNS_NAME)

$(MLX_DIR)/libmlx.a:
	make -C $(MLX_DIR)

# Rule for compiling object files
$(OBJ_DIR)%.o: %.c
	$(CC) $(CFLAGS) -I $(INCLUDE) -c $< -o $@

$(BNS_OBJ_DIR)%.o: %.c
	$(CC) $(CFLAGS) -I $(BNS_INCLUDE) -c $< -o $@

# Cleanup rules
clean:
	make clean -C $(MLX_DIR)
	rm -rf $(OBJ_DIR)
	rm -rf $(BNS_OBJ_DIR)

fclean: clean
	rm -f $(NAME)
	rm -f $(BNS_NAME)

re: fclean all

.PHONY: all clean fclean re