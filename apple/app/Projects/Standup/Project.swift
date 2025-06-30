// Copyright 2025 Naked Software, LLC
//
// Version 1.0.0 (June 28, 2025)
//
// This Naked Standup License Agreement ("Agreement") is a legal agreement
// between you ("Licensee") and Naked Software, LLC ("Licensor") for the use
// of the Naked Standup software product ("Software"). By using the Software,
// you agree to be bound by the terms of this Agreement.
//
// 1. Grant of License
//
// Licensor grants Licensee a non-exclusive, non-transferable,
// non-sublicensable license to use the Software for non-commercial,
// educational, or other non-production purposes. Licensee may not use the
// Software for any commercial purposes without purchasing a commercial
// license from Licensor.
//
// 2. Commercial Use
//
// To use the Software for commercial purposes, Licensee must purchase a
// commercial license from Licensor. A commercial license allows Licensee to
// use the Software in production environments, build their own version, and
// add custom features or bug fixes. Licensee may not sell the Software or
// any derivative works to others.
//
// 3. Derivative Works
//
// Licensee may create derivative works of the Software for their own use,
// provided that they maintain a valid commercial license. Licensee may not
// sell or distribute derivative works to others. Any derivative works must
// include a copy of this Agreement and retain all copyright notices.
//
// 4. Sharing and Contributions
//
// Licensee may share their changes or bug fixes to the Software with others,
// provided that such changes are made freely available and not sold.
// Licensee is encouraged to contribute their bug fixes back to Licensor for
// inclusion in the Software.
//
// 5. Restrictions
//
// Licensee may not:
//
// - Use the Software for any commercial purposes without a valid commercial
//   license.
// - Sell, sublicense, or distribute the Software or any derivative works.
// - Remove or alter any copyright notices or proprietary legends on the
//   Software.
//
// 6. Termination
//
// This Agreement is effective until terminated. Licensor may terminate this
// Agreement at any time if Licensee breaches any of its terms. Upon
// termination, Licensee must cease all use of the Software and destroy all
// copies in their possession.
//
// 7. Disclaimer of Warranty
//
// The Software is provided "as is" without warranty of any kind, express or
// implied, including but not limited to the warranties of merchantability,
// fitness for a particular purpose, and noninfringement. In no event shall
// Licensor be liable for any claim, damages, or other liability, whether in
// an action of contract, tort, or otherwise, arising from, out of, or in
// connection with the Software or the use or other dealings in the Software.
//
// 8. Limitation of Liability
//
// In no event shall Licensor be liable for any indirect, incidental,
// special, exemplary, or consequential damages (including, but not limited
// to, procurement of substitute goods or services; loss of use, data, or
// profits; or business interruption) however caused and on any theory of
// liability, whether in contract, strict liability, or tort (including
// negligence or otherwise) arising in any way out of the use of the
// Software, even if advised of the possibility of such damage.
//
// 9. Governing Law
//
// This Agreement shall be governed by and construed in accordance with the
// laws of the jurisdiction in which Licensor is located, without regard to
// its conflict of law principles.
//
// 10. Entire Agreement
//
// This Agreement constitutes the entire agreement between the parties with
// respect to the Software and supersedes all prior or contemporaneous
// understandings regarding such subject matter.
//
// By using the Software, you acknowledge that you have read this Agreement,
// understand it, and agree to be bound by its terms and conditions.

import ProjectDescription

let project = Project(
    name: "Standup",
    organizationName: "Naked Software, LLC",
    options: .options(
        textSettings: .textSettings(
            usesTabs: true,
            indentWidth: 4,
            tabWidth: 4,
            wrapsLines: true
        )
    ),
    packages: [
        .remote(
            url: "https://github.com/SimplyDanny/SwiftLintPlugins",
            requirement: .exact("0.59.1")
        )
    ],
    targets: [
        .target(
            name: "Standup",
            destinations: [
                .iPad,
                .iPhone
            ],
            product: .app,
            bundleId: "software.naked.standup",
            deploymentTargets: .iOS("18.0"),
            infoPlist: .extendingDefault(with: [
                "CFBundleDisplayName": "Standup",
                "UILaunchScreen": [:]
            ]),
            sources: [
                "Standup/Sources/**"
            ],
            resources: [
                "Standup/Resources/**"
            ],
            scripts: [
                .post(
                    script: """
                        export REVEAL_SERVER_FILENAME="RevealServer.xcframework"

                        # Update this path to point to the location of RevealServer.xcframework in your project.
                        export REVEAL_SERVER_PATH="${SRCROOT}/../../Frameworks/${REVEAL_SERVER_FILENAME}"

                        # If RevealServer.xcframework exists at the specified path, run the integration script.
                        if [ -d "${REVEAL_SERVER_PATH}" ]; then
                         "${REVEAL_SERVER_PATH}/Scripts/integrate_revealserver.sh"
                        else
                         echo "Reveal Server not loaded into ${TARGET_NAME}: ${REVEAL_SERVER_FILENAME} could not be found."
                        fi
                        """,
                    name: "Integrate Reveal Server",
                    basedOnDependencyAnalysis: false
                )
            ],
            dependencies: [
                .package(product: "SwiftLintBuildToolPlugin", type: .plugin),
                .xcframework(
                    path: "../../Frameworks/RevealServer.xcframework",
                    status: .optional
                )
            ],
            settings: .settings(
                base: .init()
                    .appleGenericVersioningSystem()
                    .automaticCodeSigning(devTeam: "NZXG7K5N83")
                    .currentProjectVersion("1")
                    .debugInformationFormat(.dwarfWithDsym)
                    .marketingVersion("0.1.0")
                    .swiftVersion("6.2"),
                configurations: [
                    .debug(name: .debug),
                    .release(name: .release)
                ]
            ),
            additionalFiles: [
                "Standup/README.md",
            ],
        ),
        .target(
            name: "StandupTests",
            destinations: [
                .iPad,
                .iPhone
            ],
            product: .unitTests,
            bundleId: "software.naked.standup.tests",
            deploymentTargets: .iOS("18.0"),
            sources: [
                "StandupTests/Sources/**"
            ],
            dependencies: [
                .external(name: "ViewInspector"),
                .target(name: "Standup"),
            ],
            additionalFiles: [
                "StandupTests/README.md"
            ]
        )
    ],
    additionalFiles: [
        "README.md"
    ]
)
