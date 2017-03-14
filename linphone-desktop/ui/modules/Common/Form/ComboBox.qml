import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import Common 1.0
import Common.Styles 1.0

// =============================================================================

ComboBox {
  id: comboBox

  // ---------------------------------------------------------------------------

  property string iconRole: ''

  // ---------------------------------------------------------------------------

  background: Rectangle {
    border {
      color: ComboBoxStyle.background.border.color
      width: ComboBoxStyle.background.border.width
    }

    color: ComboBoxStyle.background.color
    radius: ComboBoxStyle.background.radius

    implicitHeight: ComboBoxStyle.background.height
    implicitWidth: ComboBoxStyle.background.width
  }

  // ---------------------------------------------------------------------------

  contentItem: Text {
    color: ComboBoxStyle.contentItem.text.color
    elide: Text.ElideRight

    font.pointSize: ComboBoxStyle.contentItem.text.fontSize

    rightPadding: comboBox.indicator.width + comboBox.spacing
    verticalAlignment: Text.AlignVCenter

    text: comboBox.displayText
  }

  // ---------------------------------------------------------------------------

  indicator: Icon {
    icon: 'drop_down'
    iconSize: ComboBoxStyle.background.iconSize

    x: comboBox.width - width - comboBox.rightPadding
    y: comboBox.topPadding + (comboBox.availableHeight - height) / 2
  }

  // ---------------------------------------------------------------------------

  delegate: ItemDelegate {
    id: item

    readonly property var flattenedModel: textRole.length
      && (typeof modelData !== 'undefined' ? modelData : model)

    hoverEnabled: true
    width: comboBox.width

    background: Rectangle {
      color: item.hovered
        ? ComboBoxStyle.delegate.color.hovered
        : ComboBoxStyle.delegate.color.normal

      Rectangle {
        anchors.left: parent.left
        color: ComboBoxStyle.delegate.indicator.color

        height: parent.height
        width: ComboBoxStyle.delegate.indicator.width

        visible: item.hovered
      }

      Rectangle {
        anchors.bottom: parent.bottom
        color: ComboBoxStyle.delegate.separator.color

        height: ComboBoxStyle.delegate.separator.height
        width: parent.width

        visible: comboBox.count !== index + 1
      }
    }

    contentItem: RowLayout {
      spacing: ComboBoxStyle.delegate.contentItem.spacing
      width: item.width

      Icon {
        Layout.alignment: Qt.AlignVCenter

        icon: {
          var iconRole = comboBox.iconRole
          return (iconRole.length && item.flattenedModel[iconRole]) || ''
        }
        iconSize: ComboBoxStyle.delegate.contentItem.iconSize

        visible: icon.length > 0
      }

      Text {
        Layout.fillWidth: true

        color: ComboBoxStyle.delegate.contentItem.text.color
        elide: Text.ElideRight

        font {
          bold: comboBox.currentIndex === index
          pointSize: ComboBoxStyle.delegate.contentItem.text.fontSize
        }

        text: item.flattenedModel[textRole] || modelData
      }
    }
  }
}