#!/bin/bash

# This script downloads / unpacks each of the Redmine plugins into the plugins
# directory.
#
# Downloading a named, stable version of a plugin is preferable to cloning the
# repository and using the development version.


PLUGINS_DIR=/srv/docker/redmine/redmine/plugins

# Copy over pre- and post-install scripts needed by some plugins.
cp plugins/pre-install.sh plugins/post-install.sh ${PLUGINS_DIR}

# Switch to the plugins directory
cd ${PLUGINS_DIR}

#
#
# Now download / unpack plugins
#
#

# Allow an issue to reference multiple projects
#git clone https://github.com/jbbarth/redmine_base_deface.git
#git clone https://github.com/nanego/redmine_multiprojects_issue.git

# Display a tab to hide the sidebar
git clone https://github.com/bdemirkir/sidebar_hide.git

# Kanban board
#git clone https://framagit.org/infopiiaf/redhopper.git

# Dashboard
REDMINE_DASHBOARD_NAME=redmine_dashboard
REDMINE_DASHBOARD_VERSION=2.7.1
REDMINE_DASHBOARD_FILE=redmine_dashboard-v${REDMINE_DASHBOARD_VERSION}.tar.gz
REDMINE_DASHBOARD_URL=https://github.com/jgraichen/redmine_dashboard/releases/download/v${REDMINE_DASHBOARD_VERSION}/${REDMINE_DASHBOARD_FILE}

if [ ! -d "${REDMINE_DASHBOARD_NAME}" ]; then
	wget ${REDMINE_DASHBOARD_URL}
	tar xf ${REDMINE_DASHBOARD_FILE}
	rm ${REDMINE_DASHBOARD_FILE}
fi

# Clipboard image paste
CLIPBOARD_IMAGE_PASTE_NAME=clipboard_image_paste
CLIPBOARD_IMAGE_PASTE_VERSION=master
CLIPBOARD_IMAGE_PASTE_FILE=${CLIPBOARD_IMAGE_PASTE_VERSION}.zip
CLIPBOARD_IMAGE_PASTE_URL=https://github.com/peclik/clipboard_image_paste/archive/${CLIPBOARD_IMAGE_PASTE_FILE}

if [ ! -d "${CLIPBOARD_IMAGE_PASTE_NAME}" ]; then
	wget ${CLIPBOARD_IMAGE_PASTE_URL}
	unzip ${CLIPBOARD_IMAGE_PASTE_FILE}
	rm ${CLIPBOARD_IMAGE_PASTE_FILE}
	mv ${CLIPBOARD_IMAGE_PASTE_NAME}* ${CLIPBOARD_IMAGE_PASTE_NAME}
fi

# Code review
# https://www.r-labs.org/projects/r-labs/wiki/Code_Review_en
#
REDMINE_CODE_REVIEW_NAME=redmine_code_review
REDMINE_CODE_REVIEW_VERSION=0.8.0
REDMINE_CODE_REVIEW_FILE=${REDMINE_CODE_REVIEW_VERSION}.tar.gz
REDMINE_CODE_REVIEW_URL=https://bitbucket.org/haru_iida/redmine_code_review/get/${REDMINE_CODE_REVIEW_FILE}

if [ ! -d "${REDMINE_CODE_REVIEW_NAME}" ]; then
	wget ${REDMINE_CODE_REVIEW_URL}
	tar xf ${REDMINE_CODE_REVIEW_FILE}
	rm ${REDMINE_CODE_REVIEW_FILE}
	mv *${REDMINE_CODE_REVIEW_NAME}* ${REDMINE_CODE_REVIEW_NAME}
fi

# Checklists plugin
# HOMEPAGE: https://github.com/RCRM/redmine_checklists
REDMINE_CHECKLISTS_NAME=redmine_checklists
REDMINE_CHECKLISTS_VERSION=v3.1.5

if [ ! -d "${REDMINE_CHECKLISTS_NAME}" ]; then
	rm -rf redmine_checklists
	mkdir -p redmine_checklists
	wget -nv https://github.com/RCRM/${REDMINE_CHECKLISTS_NAME}/archive/${REDMINE_CHECKLISTS_VERSION}.tar.gz -O - \
		| tar -zvxf - --strip=1 -C ${REDMINE_CHECKLISTS_NAME}
fi

# Tags for issues and wiki pages
git clone https://github.com/ixti/redmine_tags.git

# Preview of image attachments
git clone https://github.com/paginagmbh/redmine_lightbox2.git


