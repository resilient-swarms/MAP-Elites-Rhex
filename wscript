#! /usr/bin/env python
import sys
sys.path.insert(0, sys.path[0]+'/waf_tools')

import os
import sferes
import rhex_dart

def options(opt):
    opt.load('rhex_dart')

def configure(conf):
    conf.get_env()['BUILD_GRAPHIC'] = False

    conf.load('rhex_dart')
    conf.check_rhex_dart()

def build(bld):
    libs = 'RHEX_DART RHEX_CONTROLLER DART EIGEN BOOST_DART BOOST TBB '
    graphic_libs = 'DART_GRAPHIC ' + libs
    cxxflags = bld.get_env()['CXXFLAGS']

    sferes.create_variants(bld,
                           source = 'rhex.cpp',
                           use = 'sferes2',
                           uselib = libs,
                           target = 'rhex',
                           cxxflags = cxxflags + ['-march=native'],
                           variants = ['TEXT', 'BINARY'])

    # if bld.get_env()['BUILD_GRAPHIC'] == True:
    #   sferes.create_variants(bld,
    #                          source = 'hexa_duty.cpp',
    #                          use = 'sferes2',
    #                          uselib = graphic_libs,
    #                          cxxflags = cxxflags + ['-march=native'],
    #                          target = 'hexa_duty',
    #                          variants = ['GRAPHIC'])
