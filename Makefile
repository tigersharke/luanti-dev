# PORTNAME block
PORTNAME=		luanti
DISTVERSION=	g20250716

CATEGORIES=		games
MASTER_SITES=	GH
PKGNAMESUFFIX=	-dev
DISTNAME=		${PORTNAME}-${GH_TAGNAME}
DIST_SUBDIR=	${PORTNAME}${PKGNAMESUFFIX}

# Maintainer block
MAINTAINER=		nope@nothere
COMMENT=		Near-infinite-world block sandbox game
WWW=			https://www.luanti.org/

# License block
LICENSE=		LGPL21+
LICENSE_FILE=	${WRKSRC}/doc/lgpl-2.1.txt

# dependencies
LIB_DEPENDS=	libzstd.so:archivers/zstd \
				libfreetype.so:print/freetype2

# uses block
USES=			cmake iconv:wchar_t sqlite ninja:make pkgconfig:build
USE_GITHUB=		nodefault
GH_ACCOUNT=		luanti-org
GH_PROJECT=		luanti
GH_TAGNAME=		251488b3aa4145848bb9bfb91b65bd29362a186b

# uses=cmake related variables
CMAKE_ARGS=		-DCMAKE_BUILD_TYPE="MinSizeRel" \
				-DCUSTOM_EXAMPLE_CONF_DIR="${PREFIX}/etc" \
				-DCMAKE_CXX_FLAGS="-stdlib=libc++"
#				-DCMAKE_FETCHCONTENT_FULLY_DISCONNECTED="FALSE"

TEST_ENV=		${MAKE_ENV} LC_ALL=C.UTF-8

# conflicts
CONFLICTS=		luanti minetest irrlichtMt minetest-dev irrlicht-minetest

# wrksrc block
WRKSRC=			${WRKDIR}/${PORTNAME}-${GH_TAGNAME}

# packaging list block
#DOCS=		*
#PORTDATA=		*

# options definitions
OPTIONS_DEFAULT=			CURL DOCS LTO SOUND SPATIAL SYSTEM_LUAJIT SYSTEM_FONTS SYSTEM_GMP SYSTEM_JSONCPP CLIENT OPENGL
OPTIONS_GROUP=				BUILD DATABASE MISC NEEDS SYSTEM
OPTIONS_GROUP_BUILD=		BENCHMARKS DEVTEST DOCS NCURSES PROFILING PROMETHEUS UNITTESTS #TRACY GITTRACY
OPTIONS_GROUP_DATABASE=		LEVELDB PGSQL REDIS
OPTIONS_GROUP_MISC=			LTO OPENSSLCRYPTO
OPTIONS_GROUP_NEEDS=		CURL NLS SOUND SPATIAL
OPTIONS_GROUP_SYSTEM=		SYSTEM_FONTS SYSTEM_GMP SYSTEM_JSONCPP SYSTEM_LUAJIT
OPTIONS_MULTI=				SOFTWARE
OPTIONS_MULTI_SOFTWARE=		CLIENT SERVER
OPTIONS_SINGLE=				GRAPHICS
OPTIONS_SINGLE_GRAPHICS=	GLES2 OPENGL OPENGL3
OPTIONS_SUB=				yes

# options descriptions
BENCHMARKS_DESC=			Build benchmarks (Adds some benchmark chat commands)
BUILD_DESC=					Admin/Dev needs
CLIENT_DESC=				Build client, add graphics and sdl2 support, dependencies
CURL_DESC=					Enable cURL support for fetching media: contentdb
DATABASE_DESC=				Database support
DEVTEST_DESC=				Install Development Test game also (INSTALL_DEVTEST)
DOCS_DESC=					Build and install documentation (via doxygen)
#GITTRACY_DESC=				Fetch Tracy git tag --build fails-- --purpose uncertain--
GLES2_DESC=					Enable OpenGL ES 2+ driver
GRAPHICS_DESC=				Graphics support
LEVELDB_DESC=				Enable LevelDB backend --broken - build fails--
LTO_DESC=					Build with IPO/LTO optimizations (smaller and more efficient than regular build)
MISC_DESC=					Other options
NCURSES_DESC=				Enables server side terminal (cli option: --terminal) (ENABLE_CURSES)
NEEDS_DESC=					Client essentials
NLS_DESC=					Native Language Support (ENABLE_GETTEXT)
OPENGL3_DESC=				Enable OpenGL 3+ driver (likely needs sdl2 built with OPENGLES)
OPENGL_DESC=				Enable OpenGL driver
OPENSSLCRYPTO_DESC=			Enable openssl libcrypto SHA
PGSQL_DESC=					Enable PostgreSQL map backend
PROFILING_DESC=				Use gprof for profiling (USE_GPROF)
PROMETHEUS_DESC=			Build with Prometheus metrics exporter
REDIS_DESC=					Enable Redis backend
SERVER_DESC=				Build server
SOFTWARE_DESC=				Software components
SOUND_DESC=					Enable sound via openal-soft
SPATIAL_DESC=				Enable SpatialIndex (Speeds up AreaStores)
SYSTEM_DESC=				System subsitutes
SYSTEM_FONTS_DESC=			Use or install default fonts from ports
SYSTEM_GMP_DESC=			Use gmp from ports (ENABLE_SYSTEM_GMP)
SYSTEM_JSONCPP_DESC=		Use jsoncpp from ports (ENABLE_SYSTEM_JSONCPP)
SYSTEM_LUAJIT_DESC=			Use or install luajit from ports (instead of bundled lua)
#TRACY_DESC=					Build with Tracy frame and sampling profiler --build fails--
UNITTESTS_DESC=				Build unit test sources (BUILD_UNITTESTS)

# options helpers
BENCHMARKS_CMAKE_BOOL=		BUILD_BENCHMARKS
#TRACY_BUILD_DEPENDS=		tracy>0:devel/tracy
#TRACY_CMAKE_BOOL=			BUILD_WITH_TRACY
CLIENT_LIB_DEPENDS=			libpng16.so:graphics/png
CLIENT_USES=				gl xorg jpeg sdl
CLIENT_USE=	\
							GL=glu \
							SDL=sdl2,ttf2 \
							XORG=ice,sm,x11,xext,xcb,xres,xshmfence,xau,xaw,xcomposite,xcursor,xdamage,xdmcp,\
							xfixes,xft,xinerama,xkbfile,xmu,xpm,xrandr,xrender,xscreensaver,xt,xtst,xv,xxf86vm

CLIENT_CMAKE_BOOL=			BUILD_CLIENT
CURL_LIB_DEPENDS=			libcurl.so:ftp/curl
CURL_CMAKE_BOOL=			ENABLE_CURL
DEVTEST_CMAKE_BOOL=			INSTALL_DEVTEST
DOCS_CMAKE_BOOL=			BUILD_DOCUMENTATION
GLES2_USE=					GL+=glesv2
GLES2_CMAKE_BOOL=			ENABLE_GLES2
LEVELDB_LIB_DEPENDS=		libleveldb.so:databases/leveldb
LEVELDB_CMAKE_BOOL=			ENABLE_LEVELDB
LTO_CMAKE_BOOL=				ENABLE_LTO
NCURSES_USES=				ncurses
NCURSES_CMAKE_BOOL=			ENABLE_CURSES
NLS_USES=					gettext
NLS_CMAKE_BOOL=				ENABLE_GETTEXT
NLS_LDFLAGS=				-L${LOCALBASE}/lib
OPENGL3_USE=				GL+=gl
OPENGL3_CMAKE_BOOL=			ENABLE_OPENGL3
OPENGL_USE=					GL+=gl
OPENGL_CMAKE_BOOL=			ENABLE_OPENGL
OPENSSLCRYPTO_USES=			ssl
OPENSSLCRYPTO_CMAKE_BOOL=	ENABLE_OPENSSL
PGSQL_USES=					pgsql
PGSQL_CMAKE_BOOL=			ENABLE_POSTGRESQL
PROFILING_CMAKE_BOOL=		USE_GPROF
PROMETHEUS_CMAKE_BOOL=		ENABLE_PROMETHEUS
REDIS_LIB_DEPENDS=			libhiredis.so:databases/hiredis
REDIS_CMAKE_BOOL=			ENABLE_REDIS
SERVER_CMAKE_BOOL=			BUILD_SERVER
SOUND_CMAKE_BOOL=			ENABLE_SOUND
SPATIAL_LIB_DEPENDS=		libspatialindex.so:devel/spatialindex
SPATIAL_CMAKE_BOOL=			ENABLE_SPATIAL
SYSTEM_FONTS_RUN_DEPENDS=	${LOCALBASE}/share/fonts/ChromeOS/Arimo-Bold.ttf:x11-fonts/croscorefonts-fonts-ttf \
							${LOCALBASE}/share/fonts/Droid/DroidSans.ttf:x11-fonts/droid-fonts-ttf
SYSTEM_GMP_LIB_DEPENDS=		libgmp.so:math/gmp
SYSTEM_GMP_CMAKE_BOOL=		ENABLE_SYSTEM_GMP
SYSTEM_GMP_CMAKE_ON=		-DGMP_INCLUDE_DIR="${PREFIX}/include"
SYSTEM_JSONCPP_LIB_DEPENDS=	libjsoncpp.so:devel/jsoncpp
SYSTEM_JSONCPP_CMAKE_BOOL=	ENABLE_SYSTEM_JSONCPP
SYSTEM_JSONCPP_CMAKE_ON=	-DJSON_INCLUDE_DIR="${PREFIX}/include/jsoncpp"
SYSTEM_LUAJIT_USES=			luajit
SYSTEM_LUAJIT_USE=			luajit
#SYSTEM_LUAJIT_CMAKE_BOOL=	ENABLE_LUAJIT # Redundant as one of the above includes this
UNITTESTS_CMAKE_BOOL=		BUILD_UNITTESTS

.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MCLIENT} && ${PORT_OPTIONS:MSYSTEM_LUAJIT}
CMAKE_ARGS+=	-DENABLE_LUAJIT="ON" \
				-DREQUIRE_LUAJIT="ON"
.endif

# It used to be such that <OPTION>_USE= GL+=gl,opengl would satisfy, but `make test` does not agree.
.if ${PORT_OPTIONS:MCLIENT} && ${PORT_OPTIONS:MOPENGL}
USE_GL+=		glu opengl
USE_XORG+=		xi
.endif

.if ${PORT_OPTIONS:MCLIENT}
USE_GL+=		gl
.endif

.if ${PORT_OPTIONS:MCLIENT} && ${PORT_OPTIONS:MSOUND}
USES+=			openal
LIB_DEPENDS+=	libogg.so:audio/libogg libvorbisfile.so:audio/libvorbis
.endif

# In addition to below, `make check-plist` wants the %%SERVER%% omitted from the etc/rc.d/luanti line 
# but if I do not set the config to build the server then it fails to find etc/rc.d/luanti to install,
# so it is best to include the %%SERVER%% and ignore what check-plist wants.
.if ${PORT_OPTIONS:MSERVER}
USE_RC_SUBR=	${PORTNAME}
# When the official /usr/ports/GIDs file is changed, this may be luanti instead of minetest.
# At that time the files/luanti.in will need to be modified for the user and group defined.
USERS=			minetest #USERS=			${PORTNAME}
GROUPS=			minetest #GROUPS=		${PORTNAME}
.endif

do-test-UNITTESTS-on:
.if ${PORT_OPTIONS:MCLIENT}
	cd ${WRKDIR} && ${SETENV} ${TEST_ENV} ${STAGEDIR}${PREFIX}/bin/luanti --run-unittests
.endif
.if ${PORT_OPTIONS:MSERVER}
	cd ${WRKDIR} && ${SETENV} ${TEST_ENV} ${STAGEDIR}${PREFIX}/bin/luantiserver --run-unittests
.endif

# Exactly why this must be done this way eludes me but this works and satisfies the install needs.
.if ${PORT_OPTIONS:MSYSTEM_FONTS}
pre-install:
	${RM} ${LOCALBASE}/share/luanti/fonts/Arimo-Bold.ttf
	${RM} ${LOCALBASE}/share/luanti/fonts/Arimo-BoldItalic.ttf
	${RM} ${LOCALBASE}/share/luanti/fonts/Arimo-Italic.ttf
	${RM} ${LOCALBASE}/share/luanti/fonts/Cousine-Bold.ttf
	${RM} ${LOCALBASE}/share/luanti/fonts/Cousine-BoldItalic.ttf
	${RM} ${LOCALBASE}/share/luanti/fonts/Cousine-Italic.ttf
	${RM} ${LOCALBASE}/share/luanti/fonts/Cousine-Regular.ttf
	${RM} ${LOCALBASE}/share/luanti/fonts/DroidSansFallbackFull.ttf
	${MKDIR} ${LOCALBASE}/share/luanti/fonts
	${LN} -s ${LOCALBASE}/share/fonts/ChromeOS/Arimo-Bold.ttf ${LOCALBASE}/share/luanti/fonts/Arimo-Bold.ttf
	${LN} -s ${LOCALBASE}/share/fonts/ChromeOS/Arimo-BoldItalic.ttf ${LOCALBASE}/share/luanti/fonts/Arimo-BoldItalic.ttf
	${LN} -s ${LOCALBASE}/share/fonts/ChromeOS/Arimo-Italic.ttf ${LOCALBASE}/share/luanti/fonts/Arimo-Italic.ttf
	${LN} -s ${LOCALBASE}/share/fonts/ChromeOS/Cousine-Bold.ttf ${LOCALBASE}/share/luanti/fonts/Cousine-Bold.ttf
	${LN} -s ${LOCALBASE}/share/fonts/ChromeOS/Cousine-BoldItalic.ttf ${LOCALBASE}/share/luanti/fonts/Cousine-BoldItalic.ttf
	${LN} -s ${LOCALBASE}/share/fonts/ChromeOS/Cousine-Italic.ttf ${LOCALBASE}/share/luanti/fonts/Cousine-Italic.ttf
	${LN} -s ${LOCALBASE}/share/fonts/ChromeOS/Cousine-Regular.ttf ${LOCALBASE}/share/luanti/fonts/Cousine-Regular.ttf
	${LN} -s ${LOCALBASE}/share/fonts/Droid/DroidSansFallbackFull.ttf ${LOCALBASE}/share/luanti/fonts/DroidSansFallbackFull.ttf
.endif

# These are temporary links which might only be useful for transition and a blind update, when used they indicate a deprecated solution.
post-stage:
	${RM} ${STAGEDIR}${LOCALBASE}/bin/minetest
	${RM} ${STAGEDIR}${LOCALBASE}/bin/minetestserver


post-install:
	@${ECHO_MSG} " "
	@${ECHO_MSG} "-->  "${PREFIX}/etc/"minetest.conf.example explains options and gives their default values. "
	@${ECHO_MSG} " "
	@${ECHO_MSG} "-->  Local network issues could cause singleplayer to fail. "
	@${ECHO_MSG} " "
	@${ECHO_MSG} "-->  Alternate graphics driver may be set in client config, must be set to get used."
	@${ECHO_MSG} "     -- One in minetest config, opengles likely needs sdl option built with it also."
	@${ECHO_MSG} " "
	@${ECHO_MSG} " "

#----------------------------------------------------------------------
# Warning: you might not need LIB_DEPENDS on libGL.so
# Warning: you might not need LIB_DEPENDS on libSDL2.so
# Warning: you might not need LIB_DEPENDS on libSDL2_ttf.so
# Warning: you might not need LIB_DEPENDS on libopenal.so.1
#----------------------------------------------------------------------
#----------------------------------------------------------------------
#CMake Warning:
#  Manually-specified variables were not used by the project:
#
#    CMAKE_MODULE_LINKER_FLAGS
#    CMAKE_SHARED_LINKER_FLAGS
#    CMAKE_VERBOSE_MAKEFILE
#    FETCHCONTENT_FULLY_DISCONNECTED
#    ICONV_INCLUDE_DIR
#    ICONV_LIBRARIES
#    LIBICONV_INCLUDE_DIR
#    LIBICONV_LIBRARIES
#    LIBICONV_LIBRARY
#----------------------------------------------------------------------

.include <bsd.port.mk>
