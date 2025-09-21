#!/bin/bash

# install.sh - セットアップスクリプト
# settings.json.example から .env の環境変数を使って settings.json を生成します

set -e

echo "🚀 Gemini CLI プロジェクトのセットアップを開始します..."

# 環境変数 PROJECT_ROOT が設定されているかを確認
if [ -z "$PROJECT_ROOT" ]; then
    echo "❌ エラー: 環境変数 PROJECT_ROOT が設定されていません"
    echo "   PROJECT_ROOT を環境変数として設定してください。"
    echo "   例: export PROJECT_ROOT=/path/to/your/project"
    exit 1
fi

echo "📁 PROJECT_ROOT: $PROJECT_ROOT"

# settings.json.example の存在確認
SETTINGS_EXAMPLE="$PROJECT_ROOT/workspace/.gemini/settings.json.example"
if [ ! -f "$SETTINGS_EXAMPLE" ]; then
    echo "❌ エラー: $SETTINGS_EXAMPLE が見つかりません"
    exit 1
fi

# 出力ディレクトリの作成
OUTPUT_DIR="$PROJECT_ROOT/workspace/.gemini"
mkdir -p "$OUTPUT_DIR"

# settings.json の生成
SETTINGS_OUTPUT="$OUTPUT_DIR/settings.json"
echo "🔄 settings.json を生成しています..."

# PROJECT_ROOT を実際の値に置換
sed "s|PROJECT_ROOT|$PROJECT_ROOT|g" "$SETTINGS_EXAMPLE" > "$SETTINGS_OUTPUT"

if [ $? -eq 0 ]; then
    echo "✅ settings.json を生成しました: $SETTINGS_OUTPUT"
    echo "📝 生成された内容:"
    cat "$SETTINGS_OUTPUT"
else
    echo "❌ エラー: settings.json の生成に失敗しました"
    exit 1
fi

echo ""
echo "🎉 セットアップが完了しました！"
echo "   使用したPROJECT_ROOT: $PROJECT_ROOT"
echo "   生成されたファイル: $SETTINGS_OUTPUT"
echo ""
echo "💡 使用方法:"
echo "   Gemini CLI で $SETTINGS_OUTPUT を設定ファイルとして使用してください。"
